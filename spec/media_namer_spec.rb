require 'spec_helper'

describe MediaRenamer::MediaNamer do
  let(:filepath) { "path/to/media_file" }
  subject        { described_class.new(filepath) }

  describe '#run' do
    let(:matcher) { double(MediaRenamer::Matcher) }

    before do
      expect(MediaRenamer::Matcher).to receive(:new).and_return(matcher)
    end

    describe 'when media type match based on filename' do
      let(:filename_info) do
        {
          type: :movie,
          metadata: {
            title:        'Saving Private Ryan',
            release_year: '1988'
          }
        }
      end

      let(:storing_data) do
        {
          path:     'Testing',
          filename: 'Media File.mp4'
        }
      end

      let(:library_namer) { double(MediaRenamer::LibraryNaming) }

      before do
        expect(matcher).to receive(:find_match).
          with(filepath).and_return(filename_info)

        expect(MediaRenamer::LibraryNaming).to receive(:new).
          with(filename_info[:type], filename_info[:metadata]).
          and_return(library_namer)

        expect(library_namer).to receive(:store_path).
          and_return(storing_data)
      end

      describe '#media_type' do
        it 'returns media type of file' do
          subject.run
          expect(subject.media_type).to eq(:movie)
        end
      end

      describe '#store_path' do
        it 'returns media type of file' do
          subject.run
          filepath = File.join(storing_data[:path], storing_data[:filename])
          expect(subject.store_path).to eq(filepath)
        end
      end
    end

    describe "when media type doesn't match anything" do
      before do
        expect(matcher).to receive(:find_match).with(filepath).and_return(nil)
      end

      it 'raises UnknownMediaType error' do
        expect { subject.run }.to raise_error(MediaRenamer::UnknownMediaTypeError)
      end
    end
  end
end
