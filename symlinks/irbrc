%w( rubygems pp irb/completion ).each { |lib| require lib }

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  puts "Wirble not installed.  `sudo gem install wirble` to install."
end

# ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

module Readline
  module History
    LOG = "#{ENV['HOME']}/.irb_history"
    def self.write_log(line)
      File.open(LOG, 'ab') {|f| f << "#{line}\n"}
    end
    def self.start_session_log
      write_log("\n# session start: #{Time.now}\n\n")
      at_exit { write_log("\n# session stop: #{Time.now}\n") }
    end
  end
  alias :old_readline :readline
  def readline(*args)
    begin
      line = old_readline(*args)
      History.write_log(line)
    rescue
    end
    line
  end
end

Readline::History.start_session_log

require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true

# vim:ft=ruby:
