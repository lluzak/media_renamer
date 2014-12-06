require 'spec_helper'

describe MediaRenamer::Watcher do
  let(:config_path)   { File.expand_path('fixtures/config.yml', File.dirname(__FILE__)) }
  let(:configuration) { MediaRenamer::Configuration.new(config_path) }
  let(:notifier)      { double(INotify::Notifier) }

  before do
    configuration.read!
  end

  subject { described_class.new(configuration, notifier) }

  describe '#begin' do
    describe 'when event come about moving or changing a file' do

      let(:event) do
        double(INotify::Event,
          name:          'new_file.mp4',
          absolute_name: 'example/path/to/the/main/download/directory/new_file.mp4'
        )
      end

      before do
        expect(notifier).to receive(:watch).
          with('example/path/to/the/main/download/directory', :moved_to, :create).
          and_yield(event)

        expect(notifier).to receive(:run)
      end

      describe 'when file media type not recognized' do
        let(:store_path) { "formatted_file_name.mp4" }
        let(:namer)      { double(MediaRenamer::MediaNamer, store_path: store_path, media_type: :movie) }

        before do
          expect(MediaRenamer::MediaNamer).to receive(:new).
            with('new_file.mp4').
            and_return(namer)

          expect(namer).to receive(:run).
            and_raise(MediaRenamer::UnknownMediaTypeError)
        end

        it 'continues to watch directory for new new files' do
          subject.begin
        end
      end

      describe 'when file media type detected' do
        let(:store_path)  { "formatted_file_name.mp4" }
        let(:mover)       { double(MediaRenamer::FileMover) }
        let(:namer)       { double(MediaRenamer::MediaNamer, store_path: store_path, media_type: :movie) }
        let(:source)      { 'example/path/to/the/main/download/directory/new_file.mp4' }
        let(:destination) { File.join(configuration.library_movie_directory, store_path) }

        before do
          expect(MediaRenamer::MediaNamer).to receive(:new).
            with('new_file.mp4').
            and_return(namer)

          expect(namer).to receive(:run)

          expect(MediaRenamer::FileMover).to receive(:new).
            with(source, destination).
            and_return(mover)

          expect(mover).to receive(:move_file)
        end

        it 'runs namer on filename and move file to proper directory' do
          subject.begin
        end
      end
    end
  end
end
