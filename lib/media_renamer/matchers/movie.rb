module MediaRenamer::Matchers
  class Movie
    FILENAME_REGEX = /
      ^(?<title>[^\[\]][A-z0-9 \.-]+?)
      (?=(?:\(|)(?:[0-9]{4})(?:\)|))
      (\(|)(?<year>[0-9]{4})
      .*
      (?<=\.)(?<extension>[A-z0-9]{2,4})$
    /x

    def retrieve_information_from_filename(filename)
      return nil if sample_file?(filename)

      result = filename.match(FILENAME_REGEX)
      result && build_metadata(result)
    end

    private

    def sample_file?(filename)
      filename.match(/sample/i)
    end

    def build_metadata(result)
      {
        title:        titleize(result['title']),
        release_year: result['year'],
        extension:    result['extension']
      }
    end

    def titleize(text)
      text.tr(".", " ").strip
    end
  end
end
