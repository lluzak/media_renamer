# encoding: utf-8

module MediaRenamer
  class Watcher
    def initialize(configuration, notifier = NotifierProxy.notifier)
      @configuration   = configuration
      @notifier        = notifier
    end

    def begin
      create_watch_directory unless Dir.exist?(@configuration.watch_directory)

      @notifier.watch(@configuration.watch_directory) do
        check_files_in_watching_directory
      end

      logger.info("Starting watching directory...")
      check_files_in_watching_directory
      @notifier.run
    end

    private

    def create_watch_directory
      FileUtils.mkdir_p @configuration.watch_directory
    end

    def check_files_in_watching_directory
      files_in_watching_directory.each do |file|
        detect_and_move_file(file)
      end
    end

    def files_in_watching_directory
      watch_directory_path = Pathname.new(@configuration.watch_directory)
      file_pattern         = File.join(@configuration.watch_directory, "**/*.*")

      Dir[file_pattern].map do |file|
        Pathname.new(file).relative_path_from(watch_directory_path).to_s
      end
    end

    def detect_and_move_file(filepath)
      filename = File.basename(filepath)

      begin
        namer = MediaNamer.new(filename)
        namer.run

        logger.info("#{filename}: File detected as #{namer.media_type}")
        move_file_to_library(filepath, namer)
      rescue UnknownMediaTypeError
        logger.warn("#{filename}: Unable to determine media type of the file")
      rescue SourceNotExistError
        logger.warn("#{filename}: File no longer exist in watch directory")
      end
    end

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
  end
end
