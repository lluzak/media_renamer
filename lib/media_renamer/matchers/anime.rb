module MediaRenamer::Matchers
  class Anime
    FILENAME_REGEX = /
      \[(?<translation_group>[A-z0-9-]+)\]\s
      (?<title>[-\s\w\:\+!]+)
      \s-\s(?<episode>[0-9]{1,3})
      .+
      (?<=\.)(?<extension>[A-z0-9]{2,3})
    /x

    FILENAME_REGEX_WITHOUT_HYPEN = /
      \[(?<translation_group>[A-z0-9-]+)\]\s
      (?<title>[-\s\w\:\+!]+)
      \s(?<episode>[0-9]{1,3})
      .+
      (?<=\.)(?<extension>[A-z0-9]{2,3})
    /x

    def retrieve_information_from_filename(filename)
      metadata = nil

      [FILENAME_REGEX, FILENAME_REGEX_WITHOUT_HYPEN].each do |regex|
        result = regex.match(filename)
        if result
          metadata = build_metadata(result)
          break
        end
      end

      metadata
    end

    private

    def build_metadata(result)
      {
        translation_group: result['translation_group'],
        title:             result['title'],
        episode:           result['episode'],
        extension:         result['extension']
      }
    end
  end
end
