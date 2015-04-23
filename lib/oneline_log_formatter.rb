require 'time'

class OnelineLogFormatter
  FORMAT = "%s [%s] %s\n"

  def initialize(opts={})
  end

  def call(severity, time, progname, msg)
    FORMAT % [format_datetime(time), severity, format_message(msg)]
  end

  private
  def format_datetime(time)
    time.iso8601
  end

  def format_severity(severity)
    severity
  end

  def format_message(message)
    case message
    when ::Exception
      e = message
      "#{e.class} (#{e.message})\\n  #{e.backtrace.join("\\n  ")}"
    else
      message.to_s.gsub(/\n/, "\\n")
    end
  end
end
