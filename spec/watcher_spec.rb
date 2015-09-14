require 'spec_helper'

describe MediaRenamer::Watcher do
  let(:config_path)   { File.expand_path('fixtures/config.yml', File.dirname(__FILE__)) }
  let(:configuration) { MediaRenamer::Configuration.new(config_path) }
  let(:notifier)      { double("Notifier", watch: true) }

  before do
    configuration.read!
  end

  subject { described_class.new(configuration, notifier) }

  describe '#begin' do

    describe 'when files exists in directory' do
      before do
        expect(notifier).to receive(:watch).
          with('example/path/to/the/main/download/directory')

        expect(notifier).to receive(:run)

        expect(Dir).to receive(:[]).
          and_return(["filename.mp4", "filename2.avi"])
      end


      it 'runs detection on files in directory' do
        subject.begin
      end

      describe "when watch directory doesn't exist" do
        it 'creates watch directory' do
          expect(Dir).to receive(:exist?).and_return(false)
          expect(FileUtils).to receive(:mkdir_p).with(configuration.watch_directory)

          subject.begin
        end
      end
    end
  end
end
