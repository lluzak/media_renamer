require 'spec_helper'

describe MediaRenamer::Matchers::Movie do
  subject { described_class.new }

  describe '#retrieve_information_from_filename' do
    describe 'extract information from different filenames' do

      it 'Brick Mansions 2014 720p BRRip x264 AAC-JYK.mp4' do
        filename = 'Brick Mansions 2014 720p BRRip x264 AAC-JYK.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Brick Mansions',
          release_year: '2014',
          extension:    'mp4'
        )
      end

      it 'X-Men Days of Future Past 2014 KORSUB 720p HDRip x264 AC3-JYK.mkv' do
        filename = 'X-Men Days of Future Past 2014 KORSUB 720p HDRip x264 AC3-JYK.mkv'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'X-Men Days of Future Past',
          release_year: '2014',
          extension:    'mkv'
        )
      end

      it 'Goal of the Dead 2014 720p BRRip x264 AAC-JYK.mp4' do
        filename = 'Goal of the Dead 2014 720p BRRip x264 AAC-JYK.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Goal of the Dead',
          release_year: '2014',
          extension:    'mp4'
        )
      end

      it 'Maleficent (2014) DVDRip XviD-MAXSPEED www.torentz.3xforum.ro.avi' do
        filename = 'Maleficent (2014) DVDRip XviD-MAXSPEED www.torentz.3xforum.ro.avi'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Maleficent',
          release_year: '2014',
          extension:    'avi'
        )
      end

      it 'Godzilla.2012.720p.WEBRiP.XviD-VAiN.avi' do
        filename = 'Godzilla.2012.720p.WEBRiP.XviD-VAiN.avi'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Godzilla',
          release_year: '2012',
          extension:    'avi'
        )
      end

      it 'Captain.America.The.Winter.Soldier.2014.1080p.BluRay.x264.YIFY.mp4' do
        filename = 'Captain.America.The.Winter.Soldier.2014.1080p.BluRay.x264.YIFY.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Captain America The Winter Soldier',
          release_year: '2014',
          extension:    'mp4'
        )
      end

      it 'Saving Private Ryan.1998.720p.BrRip.x264.YIFY.mp4' do
        filename = 'Saving Private Ryan.1998.720p.BrRip.x264.YIFY.mp4'

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          title:        'Saving Private Ryan',
          release_year: '1998',
          extension:    'mp4'
        )
      end
    end

    describe "When filename contains Sample word" do
      it 'return nil' do
        filename = "Now You See Me 2013 Extended 720p BRRip XviD AC3 - KINGDOM - Sample.avi"
        expect(subject.retrieve_information_from_filename(filename)).to be_nil
      end
    end

    describe "when filename doesn't match" do
      it 'returns nil' do
        filename = 'Saving Private Ryan.54.720p.BrRip.x264.YIFY.mp4'
        expect(subject.retrieve_information_from_filename(filename)).to be_nil
      end
    end
  end
end
