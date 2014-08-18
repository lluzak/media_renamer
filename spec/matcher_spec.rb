require 'spec_helper'

describe MediaRenamer::Matcher do
  subject { described_class.new }

  describe '#find_match' do
    describe 'when media type is movie' do
      let(:filename) { 'Saving Private Ryan.1998.720p.BrRip.x264.YIFY.mp4' }
      let(:metadata) do
        {
          title:        'Saving Private Ryan',
          release_year: '1988'
        }
      end

      before do
        allow_any_instance_of(MediaRenamer::Matchers::TvShow).
          to receive('retrieve_information_from_filename').and_return(nil)

        expect_any_instance_of(MediaRenamer::Matchers::Movie).
          to receive('retrieve_information_from_filename').and_return(metadata)

        allow_any_instance_of(MediaRenamer::Matchers::Anime).
          to receive('retrieve_information_from_filename').and_return(nil)
      end

      it 'returns media information for filename' do
        expect(subject.find_match(filename)).to eql(
          type: :movie,
          metadata: metadata
        )
      end
    end

    describe 'when media type is tv show' do
      let(:filename) { 'The.Suits.S02E20.HDTV.x264-KILLERS.mp4' }
      let(:metadata) do
        {
          title:     'The Suits',
          season:    '02',
          episode:   '20',
          extension: 'mp4'
        }
      end

      before do
        expect_any_instance_of(MediaRenamer::Matchers::TvShow).
          to receive('retrieve_information_from_filename').and_return(metadata)

        allow_any_instance_of(MediaRenamer::Matchers::Movie).
          to receive('retrieve_information_from_filename').and_return(nil)

        allow_any_instance_of(MediaRenamer::Matchers::Anime).
          to receive('retrieve_information_from_filename').and_return(nil)
      end

      it 'returns media information for filename' do
        expect(subject.find_match(filename)).to eql(
          type: :tv_show,
          metadata: metadata
        )
      end
    end

    describe 'when media type is anime' do
      let(:filename) { '[MikiSubs] Ghost Town - 02 [720p].mkv' }
      let(:metadata) do
        {
          translation_group: 'MikiSubs',
          title:             'Ghost Town',
          episode:           '02',
          extension:         'mkv'
        }
      end

      before do
        allow_any_instance_of(MediaRenamer::Matchers::TvShow).
          to receive('retrieve_information_from_filename').and_return(nil)

        allow_any_instance_of(MediaRenamer::Matchers::Movie).
          to receive('retrieve_information_from_filename').and_return(nil)

        expect_any_instance_of(MediaRenamer::Matchers::Anime).
          to receive('retrieve_information_from_filename').and_return(metadata)
      end

      it 'returns media information for filename' do
        expect(subject.find_match(filename)).to eql(
          type:     :anime,
          metadata: metadata
        )
      end
    end

    describe "when filename doesn't match" do
      let(:filename) { 'Wrong.Name.E3421.mp3' }

      before do
        expect_any_instance_of(MediaRenamer::Matchers::TvShow).
          to receive('retrieve_information_from_filename').and_return(nil)

        expect_any_instance_of(MediaRenamer::Matchers::Movie).
          to receive('retrieve_information_from_filename').and_return(nil)

        expect_any_instance_of(MediaRenamer::Matchers::Anime).
          to receive('retrieve_information_from_filename').and_return(nil)
      end

      it 'returns nil' do
        expect(subject.find_match(filename)).to be_nil
      end
    end
  end
end
