module MediaRenamer::Matchers
  class TvShow
    FILENAME_REGEX = /
      ^(?<title>[A-z0-9 \.]+)
      (?=S[0-9]{2}E[0-9]{2})
      S(?<season>[0-9]{2})
      E(?<episode>[0-9]{2})
      .*
      (?<=\.)(?<extension>[A-z0-9]{2,4})$
    /x

    def retrieve_information_from_filename(filename)
      result = FILENAME_REGEX.match(filename)
      result && build_metadata(result)
    end

    private

    def build_metadata(result)
      {
        title:     titleize(result['title']),
        season:    result['season'],
        episode:   result['episode'],
        extension: result['extension']
      }
    end

    def titleize(text)
      text.gsub(".", " ").strip
    end

  end
end
