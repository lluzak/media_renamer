module NotifierProxy
  def self.notifier
    if RUBY_PLATFORM =~ /linux/i
      load_inotify
    elsif RUBY_PLATFORM =~ /darwin/i
      load_fsevent
    else
      raise ArgumentError("Unknown ruby platform. Unable to load watcher.")
    end
  end

  private

  def self.load_inotify
    require 'media_renamer/notifiers/inotify'
    MediaRenamer::Notifiers::INotify.new
  end

  def self.load_fsevent
    require 'media_renamer/notifiers/fsevent'
    MediaRenamer::Notifiers::FSevent.new
  end
end
