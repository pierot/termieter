import XMonad

import System.Exit

import XMonad.Actions.WithAll(sinkAll)

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import XMonad.Util.Loggers
import XMonad.Util.EZConfig(additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce

import Data.Monoid
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Main options, only comment what is ambigous

myTerminal            = "kitty"
myFocusFollowsMouse   = True
myClickJustFocuses    = False
myBorderWidth         = 1
myModMask        
  = mod4Mask
myWorkspaces          = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor   = "#282C34"
myFocusedBorderColor  = "#61AFEF"

myLayout = avoidStruts $ smartBorders $ mkToggle (single NBFULL) (layoutHook def)

-- Keybindings

myKeys :: [(String, X ())]
myKeys = 
    -- Xmonad
    [ ("M-q", spawn "xmonad --recompile; xmonad --restart")
    , ("M-S-M1-q", io (exitWith ExitSuccess))

    -- Start programs
    --, ("M-<Return>", spawn (myTerminal))
    , ("M-a", spawn (myTerminal ++ " pulsemixer"))
    , ("M-o f", spawn "nemo")
    , ("M-w", spawn "firefox")
    , ("M-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
    , ("M-S-f", sinkAll)
    , ("M-p", spawn "dmenu_run -fn 'JetBrainsMono Nerd Font Mono-12' -nb '#000000'")
    , ("M-S-e", spawn "/home/jeroen/.termieter/users/jeroenb/bin/dmenupower")
    , ("M-<F1>", spawn ("feh -F --zoom 150 /home/jeroen/Downloads/xmbindings.png"))
    , ("M-S-<F1>", spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    , ("M-<Print>", spawn ("scrot ~/Dropbox/Screenshots/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'"))
    , ("M-S-<Print>", spawn ("scrot -s ~/Dropbox/Screenshots/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'"))
    ]

myStartupHook :: X ()
myStartupHook = setWMName "LG3D"

myConfig = def 
  { terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , clickJustFocuses   = myClickJustFocuses
  , borderWidth        = myBorderWidth
  , modMask            = myModMask
  , workspaces         = myWorkspaces
  , normalBorderColor  = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , layoutHook         = myLayout
  , startupHook        = myStartupHook
  , manageHook         = manageDocks <+> myManageHook           -- Match on certain windows
  } `additionalKeysP` myKeys
    `removeKeysP` ["M-S-q"]

-- Xmobar
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = xmobarColor "#61AFEF" "" . wrap "" "" 
    , ppHidden          = lowWhite . wrap """"
    , ppHiddenNoWindows = lowWhite . wrap """"
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#7aa2f7" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

-- Manage specific windows
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , title =? "Oracle VM VirtualBox Manager"  --> doFloat
     , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
     , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
     , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
     ]

-- Main entry point

main :: IO ()
main = xmonad 
      . ewmhFullscreen 
      . docks
      . ewmh  
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      $ myConfig 
                
-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
