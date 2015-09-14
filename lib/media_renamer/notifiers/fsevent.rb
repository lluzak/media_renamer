require 'rb-fsevent'

module MediaRenamer::Notifiers
  class FSevent
    def initialize
      @fsevent = FSEvent.new
    end

    def watch(directory, &block)
      @fsevent.watch(directory, &block)
    end

    def run
      @fsevent.run
    end
  end
end
