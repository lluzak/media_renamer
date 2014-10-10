require 'spec_helper'

describe MediaRenamer::FileMover do
  let(:source_path)      { '/orignal/path/to/file.mkv' }
  let(:destination_path) { '/new/file/path/with/name.mkv' }
  subject                { described_class.new(source_path, destination_path) }

  describe '#move_file' do
    it 'moves source file to destination directory' do
      expect(FileUtils).to receive(:mkdir_p).with("/new/file/path/with")
      expect(FileUtils).to receive(:mv).with(source_path, destination_path)

      subject.move_file
    end

    describe "when source file doesn't exist" do
      before do
        expect(FileUtils).to receive(:mkdir_p).with("/new/file/path/with")
        expect(FileUtils).to receive(:mv).
          with(source_path, destination_path).
          and_raise(Errno::ENOENT.new(source_path))
      end

      it 'raises SourceNotExistError' do
        expect { subject.move_file }.to raise_error(MediaRenamer::SourceNotExistError)
      end
    end
  end
end
