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
          and_return([])
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

    describe 'when changes in watch directory detected' do
      before do
        expect(notifier).to receive(:watch).and_yield
        expect(notifier).to receive(:run)

        expect(Dir).to receive(:[]).
          and_return([])

        expect(Dir).to receive(:[]).
          and_return(["tv_show.mkv", "directory/movie.mp4"])
      end

      it 'detects and moves new files' do
        expect(MediaRenamer::MediaNamer).to receive(:new).
          with("movie.mp4").and_call_original

        expect(MediaRenamer::MediaNamer).to receive(:new).
          with("tv_show.mkv").and_call_original

        subject.begin
      end
    end
  end
end
