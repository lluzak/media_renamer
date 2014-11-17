require 'spec_helper'

describe MediaRenamer::Configuration do
  subject { described_class.new(config_path) }

  describe 'reader methods' do
    let(:config_path) { File.expand_path('fixtures/config.yml', File.dirname(__FILE__)) }
    before { subject.read! }

    describe '#watch_directory' do
      it { expect(subject.watch_directory).to eq("example/path/to/the/main/download/directory") }
    end

    describe '#library_movie_directory' do
      it { expect(subject.library_movie_directory).to eq("/example/path/to/the/main/library/directory/Movies") }
    end

    describe '#library_tv_show_directory' do
      it { expect(subject.library_tv_show_directory).to eq("/example/path/to/the/main/library/directory/TV Shows") }
    end

    describe '#library_anime_directory' do
      it { expect(subject.library_anime_directory).to eq("/example/path/to/the/main/library/directory/Animes") }
    end
  end

  describe '#read' do
    describe 'when file exist' do
      describe 'when config is parseable' do
        let(:config_path) { File.expand_path('fixtures/config.yml', File.dirname(__FILE__)) }

        it 'returns self' do
          expect(subject.read!).to eq(subject)
        end
      end

      describe "when config isn't parseable" do
        let(:config_path) { File.expand_path('fixtures/malformed_config.yml', File.dirname(__FILE__)) }

        it 'raise ConfigFileError' do
          expect { subject.read! }.to raise_error(MediaRenamer::ConfigFileError).
            with_message(/fixtures\/malformed_config.yml contains malformed content/)
        end
      end

      describe 'when config missing required keys' do
        let(:config_path) { File.expand_path('fixtures/incomplete_config.yml', File.dirname(__FILE__)) }

        it 'raise ConfigFileError' do
          expect { subject.read! }.to raise_error(MediaRenamer::ConfigFileError).
            with_message(/fixtures\/incomplete_config.yml is missing base_path or watch_directory/)
        end
      end
    end

    describe "when file doesn't exist" do
      let(:config_path) { File.expand_path('fixtures/non_exist.yml', File.dirname(__FILE__)) }

      it 'raise ConfigFileError' do
        expect { subject.read! }.to raise_error(MediaRenamer::ConfigFileError).
          with_message(/fixtures\/non_exist.yml not found/)
      end
    end
  end
end
