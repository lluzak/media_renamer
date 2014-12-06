# encoding: utf-8

require 'rb-inotify'

module MediaRenamer
  class Watcher
    def initialize(configuration, notifier = INotify::Notifier.new)
      @configuration = configuration
      @notifier      = notifier
    end

    def begin
      @notifier.watch(@configuration.watch_directory, :moved_to, :create) do |event|
        begin
          namer = MediaNamer.new(event.name)
          namer.run

          logger.info("#{event.name}: File detected as #{media_type_name(namer.media_type)}")
          move_file_to_library(event.name, namer)
        rescue UnknownMediaTypeError
          logger.warn("#{event.name}: Unable to determine media type of the file")
        end
      end

      @notifier.run
    end

    private

    def logger
      @logger ||= MediaRenamer::Logger.new.logger
    end

    def move_file_to_library(filename, namer)
      source_file      = File.join(@configuration.watch_directory, filename)
      destination_file = File.join(library_directory_for(namer.media_type), namer.store_path)

      mover = FileMover.new(source_file, destination_file)
      mover.move_file
      logger.info("#{filename}: Moved file to library directory")
    end

    def library_directory_for(media_type)
      case media_type
      when :movie   then @configuration.library_movie_directory
      when :tv_show then @configuration.library_tv_show_directory
      when :anime   then @configuration.library_anime_directory
      end
    end

    def media_type_name(media_type)
      media_type.to_s.
        gsub('_', ' ').
        gsub(/\b(?<!['â`])[a-z]/) { $&.capitalize }
    end

  end
end
