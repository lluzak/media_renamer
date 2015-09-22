module MediaRenamer::Matchers
  class TvShow
    # Defiance.S02E09.720p.HDTV.x264-IMMERSE.mkv
    FILENAME_REGEX = /
      ^(?<title>[A-z0-9 \.]+)
      (?=[sS][0-9]{2}[eE][0-9]{2})
      [sS](?<season>[0-9]{2})
      [eE](?<episode>[0-9]{2})
      .*
      (?<=\.)(?<extension>[A-z0-9]{2,4})$
    /x

    # ray.donovan.309.hdtv-lol.mp4
    FILENAME_REGEX_NUMBERS = /
      ^(?<title>[A-z0-9 \.]+)
      (?=\.[0-9]{3,3}\.)
      \.
      (?<season>[0-9]{1})
      (?<episode>[0-9]{2})
      .*
      (?<=\.)(?<extension>[A-z0-9]{2,4})$
    /x

    def retrieve_information_from_filename(filename)
      return nil if sample_file?(filename)

      metadata = nil
      [FILENAME_REGEX, FILENAME_REGEX_NUMBERS].each do |regex|
        result = regex.match(filename)
        if result
          metadata = build_metadata(result)
          break
        end
      end

      metadata
    end

    private

    def sample_file?(filename)
      filename.match(/sample/i)
    end

    def build_metadata(result)
      {
        title:     cleanup_and_titleize(result['title']),
        season:    format_numbers(result['season']),
        episode:   format_numbers(result['episode']),
        extension: result['extension']
      }
    end

    def cleanup_and_titleize(text)
      cleaned = text.tr(".", " ").strip
      cleaned.titleize
    end

    def format_numbers(text)
      text.rjust(2, "0")
    end
  end
end
