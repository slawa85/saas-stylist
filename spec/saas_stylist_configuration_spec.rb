require 'spec_helper'
require 'saas_stylist'

describe 'Saas::Stylist.configure' do
  describe 'add stylized settings' do
    let(:settings) { { key1: 'some_value' } }
    before do
      Saas::Stylist.configure do |config|
        config.application_styling = settings
      end
    end

    it 'return a hash with configurations' do
      config = Saas::Stylist.configuration

      expect(config.application_styling).to eq(settings)
    end
  end

  describe 'when there are no settings' do
    before do
      Saas::Stylist.reset
    end

    it 'should return an empty hash' do
      config = Saas::Stylist.configuration
      expect(config.application_styling).to be_empty
    end
  end
end
