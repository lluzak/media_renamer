module MediaRenamer
  class LibraryNaming
    def initialize(media_type, metadata)
      @media_type = media_type
      @metadata   = metadata
    end

    def store_path
      namer.store_path
    end

    def namer
      case @media_type
      when :movie then Movie.new(@metadata)
      when :anime then Anime.new(@metadata)
      when :tv_show then TvShow.new(@metadata)
      end
    end
  end
end
