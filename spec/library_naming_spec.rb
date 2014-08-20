require 'spec_helper'

describe MediaRenamer::LibraryNaming do
  subject { described_class.new(media_type, metadata) }

  describe '#store_path' do
    describe 'when media is movie' do
      let(:media_type) { :movie }
      let(:metadata) do
        {
          title:        'X-Men Days of Future Past',
          release_year: '2014',
          extension:    'mkv'
        }
      end

      let(:media_store_info) { {filename: 'X-Men.mp4', path: 'Testing'} }
      let(:namer) { double("namer", store_path: media_store_info) }

      before do
        expect(MediaRenamer::LibraryNaming::Movie).
          to receive(:new).with(metadata).and_return(namer)
      end

      it 'calls #store_path on namer' do
        expect(namer).to receive(:store_path).and_return(media_store_info)
        subject.store_path
      end
    end

    describe 'when media is tv show' do
      let(:media_type) { :tv_show }
      let(:metadata) do
        {
          title:     'The Knick',
          season:    '01',
          episode:   '09',
          extension: 'mp4'
        }
      end

      let(:media_store_info) { {filename: 'Knick.mp4', path: 'Testing'} }
      let(:namer) { double("namer", store_path: media_store_info) }

      before do
        expect(MediaRenamer::LibraryNaming::TvShow).
          to receive(:new).with(metadata).and_return(namer)
      end

      it 'calls #store_path on namer' do
        expect(namer).to receive(:store_path).and_return(media_store_info)
        subject.store_path
      end
    end

    describe 'when media is anime' do
      let(:media_type) { :anime }
      let(:metadata) do
        {
          translation_group: 'FFF',
          title:             'Seirei Tsukai no Blade Dance',
          episode:           '04',
          extension:         'mkv'
        }
      end

      let(:media_store_info) { {filename: 'Seirei Tsukai no Blade Dance.mp4', path: 'Testing'} }
      let(:namer) { double("namer", store_path: media_store_info) }

      before do
        expect(MediaRenamer::LibraryNaming::Anime).
          to receive(:new).with(metadata).and_return(namer)
      end

      it 'calls #store_path on namer' do
        expect(namer).to receive(:store_path).and_return(media_store_info)
        subject.store_path
      end
    end
  end
end
