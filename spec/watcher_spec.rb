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
    describe 'when files exists in directory' do
      before do
        expect(notifier).to receive(:watch).
          with('example/path/to/the/main/download/directory', :recursive, :moved_to, :create)

        expect(notifier).to receive(:run)

        expect(Dir).to receive(:[]).
          and_return(["filename.mp4", "filename2.avi"])
      end

      it 'runs detection on files in directory' do
        subject.begin
      end
    end

    describe 'when event come about new directory' do
      let(:event) do
        double(INotify::Event,
          name:          'testing',
          absolute_name: 'example/path/to/the/main/download/directory/testing'
        )
      end

      before do
        expect(notifier).to receive(:watch).
          with('example/path/to/the/main/download/directory', :recursive, :moved_to, :create).
          and_yield(event)

        expect(notifier).to receive(:run)

        expect(MediaRenamer::MediaNamer).to_not receive(:new)

        expect(File).to receive(:file?).
          with('example/path/to/the/main/download/directory/testing').
          and_return(false)
      end

      it 'skips if event consider directory' do
        subject.begin
      end
    end

    describe 'when event come about moving or changing a file' do
      let(:event_absolute_name) { 'example/path/to/the/main/download/directory/testing/new_file.mp4' }

      let(:event) do
        double(INotify::Event, name: 'testing/new_file.mp4', absolute_name: event_absolute_name)
      end

      before do
        expect(notifier).to receive(:watch).
          with('example/path/to/the/main/download/directory', :recursive, :moved_to, :create).
          and_yield(event)

        expect(notifier).to receive(:run)

        expect(File).to receive(:file?).
          with(event_absolute_name).
          and_return(true)
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
        let(:source)      { event_absolute_name }
        let(:destination) { File.join(configuration.library_movie_directory, store_path) }

        before do
          expect(MediaRenamer::MediaNamer).to receive(:new).
            with('new_file.mp4').
            and_return(namer)

          expect(MediaRenamer::FileMover).to receive(:new).
            with(source, destination).
            and_return(mover)

          expect(namer).to receive(:run)
        end

        describe 'when file has been moved by third party program' do
          before do
            expect(mover).to receive(:move_file).
              and_raise(MediaRenamer::SourceNotExistError)
          end

          it 'writes into log information about missing file and continues' do
            subject.begin
          end
        end

        describe 'when file and destination directory exist' do
          before do
            expect(mover).to receive(:move_file)
          end

          it 'runs namer on filename and moves file to proper directory' do
            subject.begin
          end
        end
      end
    end
  end
end
