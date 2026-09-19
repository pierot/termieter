// taplist — list every active CGEventTap on the system.
//
// WindowServer delivers input events through a chain of event taps. A tap that
// stops draining jams the chain: the pointer lags and WindowServer burns a core
// inside add_event_vector_to_tap(). This prints every tap with its owner and
// its latency, so the jammed one is obvious.
//
// Build:  swiftc -O -o ~/.local/bin/taplist bin/taplist.swift
// Usage:  taplist

import CoreGraphics
import Darwin
import Foundation

func processName(_ pid: pid_t) -> String {
    if pid <= 0 { return "-" }
    var buf = [CChar](repeating: 0, count: 4096)
    let len = proc_pidpath(pid, &buf, UInt32(buf.count))
    if len <= 0 { return "(gone)" }
    let path = String(cString: buf)
    return (path as NSString).lastPathComponent
}

func tapPointName(_ p: CGEventTapLocation) -> String {
    switch p {
    case .cghidEventTap: return "hid"
    case .cgSessionEventTap: return "session"
    case .cgAnnotatedSessionEventTap: return "annotated"
    @unknown default: return "?"
    }
}

// Event types worth naming. A tap on mouseMoved sees the highest event volume.
let namedTypes: [(CGEventType, String)] = [
    (.mouseMoved, "move"),
    (.leftMouseDragged, "ldrag"),
    (.rightMouseDragged, "rdrag"),
    (.otherMouseDragged, "odrag"),
    (.scrollWheel, "scroll"),
    (.keyDown, "keydown"),
    (.keyUp, "keyup"),
    (.flagsChanged, "flags"),
    (.leftMouseDown, "ldown"),
    (.leftMouseUp, "lup"),
    (.rightMouseDown, "rdown"),
    (.rightMouseUp, "rup"),
]

func maskSummary(_ mask: CGEventMask) -> String {
    if mask == ~CGEventMask(0) { return "all" }
    let hit = namedTypes.filter { mask & (CGEventMask(1) << $0.0.rawValue) != 0 }.map { $0.1 }
    if hit.isEmpty { return String(format: "0x%llx", mask) }
    return hit.joined(separator: ",")
}

var count: UInt32 = 0
guard CGGetEventTapList(0, nil, &count) == .success else {
    FileHandle.standardError.write(Data("taplist: CGGetEventTapList failed\n".utf8))
    exit(1)
}
if count == 0 {
    print("no active event taps")
    exit(0)
}

let buf = UnsafeMutablePointer<CGEventTapInformation>.allocate(capacity: Int(count))
defer { buf.deallocate() }
var got = count
guard CGGetEventTapList(count, buf, &got) == .success else {
    FileHandle.standardError.write(Data("taplist: CGGetEventTapList failed\n".utf8))
    exit(1)
}

var taps = (0..<Int(got)).map { buf[$0] }
// The jammed tap is the one macOS waited longest on. Put it first.
taps.sort { $0.avgUsecLatency > $1.avgUsecLatency }

func pad(_ s: String, _ w: Int) -> String {
    s.count >= w ? s : s + String(repeating: " ", count: w - s.count)
}
func rpad(_ s: String, _ w: Int) -> String {
    s.count >= w ? s : String(repeating: " ", count: w - s.count) + s
}
func usec(_ f: Float) -> String { String(format: "%.1f", f) }

print(pad("PID", 7) + pad("PROCESS", 26) + pad("POINT", 11) + pad("MODE", 8)
      + pad("ON", 5) + rpad("AVG_US", 10) + rpad("MAX_US", 10) + rpad("MIN_US", 10)
      + "  EVENTS")

for t in taps {
    print(pad(String(t.tappingProcess), 7)
          + pad(processName(t.tappingProcess), 26)
          + pad(tapPointName(t.tapPoint), 11)
          + pad(t.options == .listenOnly ? "listen" : "active", 8)
          + pad(t.enabled ? "yes" : "NO", 5)
          + rpad(usec(t.avgUsecLatency), 10)
          + rpad(usec(t.maxUsecLatency), 10)
          + rpad(usec(t.minUsecLatency), 10)
          + "  " + maskSummary(t.eventsOfInterest))
}
