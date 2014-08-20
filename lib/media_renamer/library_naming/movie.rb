class MediaRenamer::LibraryNaming::Movie
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
    "#{@metadata[:title]}.#{@metadata[:extension]}"
  end

  def directory_path
    "#{@metadata[:title]} (#{@metadata[:release_year]})"
  end
end
