class MediaRenamer::FileMover

  def initialize(source, destination)
    @source      = source
    @destination = destination
  end

  def move_file
    destination_directory = File.dirname(@destination)

    FileUtils.mkdir_p(destination_directory)
    FileUtils.mv(@source, @destination)
  rescue Errno::ENOENT
    raise MediaRenamer::SourceNotExistError
  end

end
