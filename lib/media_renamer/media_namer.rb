module MediaRenamer
  class MediaNamer
    attr_reader :store_path, :media_type

    def initialize(filepath)
      @filepath = filepath
    end

    def run
      matcher = Matcher.new
      matched_filename = matcher.find_match(@filepath)

      raise MediaRenamer::UnknownMediaTypeError unless matched_filename
      @media_type = matched_filename[:type]

      library_namer = LibraryNaming.new(@media_type, matched_filename[:metadata])
      store_name    = library_namer.store_path
      @store_path   = File.join(store_name[:path], store_name[:filename])
    end
  end
end
