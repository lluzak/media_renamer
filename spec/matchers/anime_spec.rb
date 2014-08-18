require 'spec_helper'

describe MediaRenamer::Matchers::Anime do
  subject { described_class.new }

  describe '#retrieve_information_from_filename' do
    describe 'transforms different filenames' do
      it '[FFF] Seirei Tsukai no Blade Dance - 04 [DCC2713A].mkv' do
        filename = "[FFF] Seirei Tsukai no Blade Dance - 04 [DCC2713A].mkv"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          translation_group: 'FFF',
          title:             'Seirei Tsukai no Blade Dance',
          episode:           '04',
          extension:         'mkv'
        )
      end

      it '[HorribleSubs] Tokyo Ghoul - 06 [720p].mkv' do
        filename = "[HorribleSubs] Tokyo Ghoul - 06 [720p].mkv"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          translation_group: 'HorribleSubs',
          title:             'Tokyo Ghoul',
          episode:           '06',
          extension:         'mkv'
        )
      end

      it '[DeadFish] M3: Sono Kuroki Hagane - 16 [720p][AAC].mp4' do
        filename = "[DeadFish] M3: Sono Kuroki Hagane - 16 [720p][AAC].mp4"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          translation_group: 'DeadFish',
          title:             'M3: Sono Kuroki Hagane',
          episode:           '16',
          extension:         'mp4'
        )
      end

      it '[Hiryuu] Sword Art Online II - 05 [720p H264 AAC][56BEF6D0].mkv' do
        filename = "[Hiryuu] Sword Art Online II - 05 [720p H264 AAC][56BEF6D0].mkv"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          translation_group: 'Hiryuu',
          title:             'Sword Art Online II',
          episode:           '05',
          extension:         'mkv'
        )
      end

      it '[Migoto] Sin Strange+ - 05 (1280x720 Hi10P AAC) [AA7ADCB0].mkv' do
        filename = "[Migoto] Sin Strange+ - 05 (1280x720 Hi10P AAC) [AA7ADCB0].mkv"

        expect(subject.retrieve_information_from_filename(filename)).to eql(
          translation_group: 'Migoto',
          title:             'Sin Strange+',
          episode:           '05',
          extension:         'mkv'
        )
      end
    end

    describe 'when filename is incorrect' do
      it 'returns nil' do
        filename = "[Migoto] Sin Stra+ - 321 (1280x720 Hi10P AAC) [AA7ADCB0]"
        expect(subject.retrieve_information_from_filename(filename)).to be_nil
      end
    end
  end
end
