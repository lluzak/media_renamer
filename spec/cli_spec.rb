require 'spec_helper'

describe MediaRenamer::CLI do
  let(:arguments) { [] }
  subject { described_class.new(arguments) }

  describe '#run' do
    describe 'when displaying help information' do
      let(:arguments) { ["--help"] }

      it 'shows banner info' do
        expect do
          ignore_system_exit { subject.run }
        end.to output(/media_renamer \[options\]/).to_stdout
      end
    end

    describe "when config option isn't supply" do
      let(:arguments) { [] }

      it 'prints error message' do
        expect do
          ignore_system_exit { subject.run }
        end.to output(/Missing options: config/).to_stdout
      end
    end

    describe "when config option points to not existing file" do
      let(:arguments) { ["--config", "spec/fixtures/config_error.yml"] }

      it 'prints error message' do
        expect do
          ignore_system_exit { subject.run }
        end.to output(/doesn't exist/).to_stdout
      end
    end
  end
end
