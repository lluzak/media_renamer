require 'spec_helper'

describe MediaRenamer::LibraryNaming::Movie do
  let(:metadata) do
    {
      title:        'X-Men Days of Future Past',
      release_year: '2014',
      extension:    'mkv'
    }
  end

  subject { described_class.new(metadata) }

  describe '#store_path' do
    it 'returns filename' do
      expect(subject.store_path[:filename]).to eq("X-Men Days of Future Past.mkv")
    end

    it 'returns directory path' do
      expect(subject.store_path[:path]).to eq("X-Men Days of Future Past (2014)")
    end
  end
end
