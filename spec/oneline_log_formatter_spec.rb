require_relative 'spec_helper'
require 'oneline_log_formatter'
require 'fileutils'
require 'logger'

describe OnelineLogFormatter do
  let(:logger) do
    Logger.new("#{log_dir}/test.log").tap {|logger|
      logger.formatter = OnelineLogFormatter.new
    }
  end
  let(:log_dir)   { "#{File.dirname(__FILE__)}/log" }
  let(:now)       { Time.now.iso8601 }

  before do
    FileUtils.mkdir_p log_dir
    Timecop.freeze(Time.now)
  end

  after do
    FileUtils.rm_rf log_dir
    Timecop.return
  end

  it :info do
    logger.info("test")
    begin
      raise ArgumentError.new('test')
    rescue => e
      logger.info(e)
    end
    File.open("#{log_dir}/test.log") do |f|
      f.gets # drop the `# Logfile created on ...` line
      expect(f.gets).to eq "#{now} [INFO] test\n"
      expect(f.gets).to match(/#{Regexp.escape(now)} \[INFO\] ArgumentError \(test\)\\n.*formatter_spec\.rb/)
    end
  end

  it :block do
    logger.fatal { "test" }
    begin
      raise ArgumentError.new('test')
    rescue => e
      logger.fatal { e }
    end
    File.open("#{log_dir}/test.log") do |f|
      f.gets # drop the `# Logfile created on ...` line
      expect(f.gets).to eq "#{now} [FATAL] test\n"
      expect(f.gets).to match(/#{Regexp.escape(now)} \[FATAL\] ArgumentError \(test\)\\n.*formatter_spec\.rb/)
    end
  end
end
