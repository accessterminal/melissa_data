require 'spec_helper'

# Dummy class for testing Config module
class API
  include MelissaData::Config
end

describe MelissaData::Config do
  let(:config) { API }

  describe '.web_smart_id' do
    it 'sets web smart id' do
      id = '01110000011001010110111001100100011001010110101001101111'

      config.web_smart_id = id

      expect(config.web_smart_id).to eq(id)
    end
  end

  describe '.configure' do
    it 'sets the api_key when used with a block' do
      id = '011010100110000101101010011000010110101001100001'

      config.configure do |conf|
        conf.web_smart_id = id
      end

      expect(config.web_smart_id).to eq(id)
    end
  end
end
