module MediaRenamer::Matchers
  class Movie
    FILENAME_REGEX = /
      ^(?<title>[A-z0-9 \.-]+?)
      (?=(?:\(|)(?:[0-9]{4})(?:\)|))
      (\(|)(?<year>[0-9]{4})
      .*
      (?<=\.)(?<extension>[A-z0-9]{2,4})$
    /x

    def retrieve_information_from_filename(filename)
      result = filename.match(FILENAME_REGEX)
      result && build_metadata(result)
    end

    private

    def build_metadata(result)
      {
        title:        titleize(result['title']),
        release_year: result['year']
      }
    end

    def titleize(text)
      text.gsub(".", " ").strip
    end
  end
end
