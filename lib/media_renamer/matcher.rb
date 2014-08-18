require 'media_renamer/matchers/anime'
require 'media_renamer/matchers/tv_show'
require 'media_renamer/matchers/movie'

module MediaRenamer
  class Matcher
    MATCHERS = {
      movie:   MediaRenamer::Matchers::Movie,
      tv_show: MediaRenamer::Matchers::TvShow,
      anime:   MediaRenamer::Matchers::Anime
    }

    def find_match(filename)
      MATCHERS.each do |matcher_type, matcher_class|
        matcher = matcher_class.new
        metadata = matcher.retrieve_information_from_filename(filename)

        return {type: matcher_type, metadata: metadata} if metadata
      end

      nil
    end

  end
end
