class MediaRenamer::LibraryNaming::TvShow
  def initialize(metadata)
    @metadata = metadata
  end

  def store_path
    {
      filename: filename,
      path:     directory_path
    }
  end

  private

  def filename
    "#{@metadata[:title]} - #{@metadata[:season].to_i}x#{@metadata[:episode]}.#{@metadata[:extension]}"
  end

  def directory_path
    season_directory = "Season #{@metadata[:season].to_i}"
    [@metadata[:title], season_directory].join('/')
  end
end
