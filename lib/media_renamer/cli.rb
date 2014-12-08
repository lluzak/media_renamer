require 'optparse'
require 'ostruct'

module MediaRenamer
  class CLI
    def initialize(args)
      @args = args
    end

    def run
      options             = OpenStruct.new
      options.config_path = nil
      opt_parser          = build_parser(options)

      begin
        opt_parser.parse!(@args)
        unless validate_options(options)
          puts opt_parser
          exit
        end

        configuration = Configuration.new(options.config_path)
        configuration.read!

        Watcher.new(configuration).begin
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument
        puts $ERROR_INFO.to_s
        puts opt_parser
        exit
      end
    end

    private

    def build_parser(options)
      OptionParser.new do |opts|
        opts.banner = "Usage: media_renamer [options]"
        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-c", "--config=FILE", "Configuration file") do |path|
          options.config_path = path
        end
      end
    end

    def validate_options(options)
      if options.config_path.nil?
        puts "Missing options: config"
      elsif !config_file_exist?(options.config_path)
        puts "Configuration file #{options.config_path} doesn't exist"
      else
        return true
      end

      false
    end

    def config_file_exist?(path)
      File.exist?(path)
    end
  end
end
