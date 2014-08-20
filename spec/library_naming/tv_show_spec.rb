require 'spec_helper'

describe MediaRenamer::LibraryNaming::TvShow do
  let(:metadata) do
    {
      title:     'The Knick',
      season:    '01',
      episode:   '09',
      extension: 'mp4'
    }
  end

  subject { described_class.new(metadata) }

  describe '#store_path' do

    it 'returns filename' do
      expect(subject.store_path[:filename]).to eq("The Knick - 1x09.mp4")
    end

    it 'returns path' do
      expect(subject.store_path[:path]).to eq("The Knick/Season 1")
    end

    describe 'returned directory path' do
      it 'includes tv show main directory' do
        expect(subject.store_path[:path]).to include("The Knick")
      end

      it 'includes season directory' do
        expect(subject.store_path[:path]).to include("Season 1")
      end
    end
  end
end
