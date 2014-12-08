require 'logger'

module MediaRenamer
  class Logger
    attr_reader :logger

    def initialize
      @logger           = ::Logger.new(STDOUT)
      @logger.formatter = proc do |severity, time, name, message|
        formatted_time = time.strftime('%Y-%m-%d %H:%M:%S')
        "#{severity.upcase} #{formatted_time}: #{message}\n"
      end

      if ENV['MEDIA_ENV'] == 'test'
        @logger.level = ::Logger::FATAL
      else
        @logger.level = ::Logger::INFO
      end
    end
  end
end