module MediaRenamer::Matchers
  class Anime
    FILENAME_REGEX = /
      \[(?<translation_group>[A-z0-9-]+)\]\s
      (?<title>[\s\w\:\+]+)
      \s-\s(?<episode>[0-9]{0,3})
      .+
      (?<=\.)(?<extension>[A-z0-9]{2,3})
    /x

    def retrieve_information_from_filename(filename)
      result = FILENAME_REGEX.match(filename)
      result && build_metadata(result)
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
