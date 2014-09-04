module MediaRenamer
  class MediaNamer

    def initialize(filepath)
      @filepath = filepath
    end

    def run
      matcher = Matcher.new
      matched_filename = matcher.find_match(@filepath)

      raise MediaRenamer::UnknownMediaTypeError unless matched_filename

      library_namer = LibraryNaming.new(matched_filename[:type], matched_filename[:metadata])
      library_namer.store_path
    end
  end
end
