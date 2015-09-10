require 'spec_helper'

describe MediaRenamer::LibraryNaming::Anime do
  let(:metadata) do
    {
      translation_group: 'FFF',
      title:             'Seirei Tsukai no Blade Dance',
      episode:           '04',
      extension:         'mkv'
    }
  end

  subject { described_class.new(metadata) }

  describe '#store_path' do

    it 'returns filename' do
      expect(subject.store_path[:filename]).to eq("Seirei Tsukai no Blade Dance EP04.mkv")
    end

    it 'returns directory path' do
      expect(subject.store_path[:path]).to eq("Seirei Tsukai no Blade Dance")
    end
  end
end
