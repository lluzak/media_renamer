class MediaRenamer::LibraryNaming::Anime
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
    "#{@metadata[:title]} EP#{@metadata[:episode]}.#{@metadata[:extension]}"
  end

  def directory_path
    @metadata[:title]
  end
end
