require 'rb-inotify'

module MediaRenamer::Notifiers
  class INotify
    def initialize
      @inotify = ::INotify::Notifier.new
    end

    def watch(directory, &block)
      @inotify.watch(directory, :recursive, :move, :create, &block)
    end

    def run
      @inotify.run
    end
  end
end
