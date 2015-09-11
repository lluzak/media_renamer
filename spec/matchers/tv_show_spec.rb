require 'spec_helper'

describe MediaRenamer::Matchers::TvShow do
  subject { described_class.new }

  describe '#retrieve_information_from_filename' do
    describe 'extract information from different filenames' do
      it 'The.Knick.S01E02.HDTV.x264-KILLERS.mp4' do
        filename = "The.Knick.S01E02.HDTV.x264-KILLERS.mp4"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'The Knick',
          season:    '01',
          episode:   '02',
          extension: 'mp4'
        )
      end

      it 'Suits.S04E08.HDTV.x264-KILLERS.mp4' do
        filename = 'Suits.S04E08.HDTV.x264-KILLERS.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'Suits',
          season:    '04',
          episode:   '08',
          extension: 'mp4'
        )
      end

      it 'Hell.on.Wheels.S04E03.HDTV.x264-ASAP.mp4' do
        filename = "Hell.on.Wheels.S04E03.HDTV.x264-ASAP.mp4"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'Hell on Wheels',
          season:    '04',
          episode:   '03',
          extension: 'mp4'
        )
      end

      it 'Defiance.S02E09.720p.HDTV.x264-IMMERSE.mkv' do
        filename = 'Defiance.S02E09.720p.HDTV.x264-IMMERSE.mkv'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'Defiance',
          season:    '02',
          episode:   '09',
          extension: 'mkv'
        )
      end

      it 'longmire.s04e01.webrip.x264-2hd.mp4' do
        filename = 'longmire.s04e01.webrip.x264-2hd.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'Longmire',
          season:    '04',
          episode:   '01',
          extension: 'mp4'
        )
      end

      it 'ray.donovan.309.hdtv-lol.mp4' do
        filename = 'ray.donovan.309.hdtv-lol.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:     'Ray Donovan',
          season:    '03',
          episode:   '09',
          extension: 'mp4'
        )
      end
    end

    describe "when filename doesn't match" do
      it 'returns nil' do
        filename = 'Defiance.E09.720p.HDTV.x264-IMMERSE.mkv'

        expect(subject.retrieve_information_from_filename(filename)).to be_nil
      end
    end
  end
end
