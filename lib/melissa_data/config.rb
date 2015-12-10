module MelissaData
  module Config
    def self.included(base)
      base.extend(self)
    end

    # @!attribute web_smart_id
    # @return [String] web smart id to be used
    attr_accessor :web_smart_id, :google_maps_api_key

    # Configures web_smart_id and property_api_url
    #   Usage example:
    #     MelissaData.configure do |config|
    #       config.web_smart_id        = ENV['MELISSA_DATA_WEB_SMART_ID']
    #       config.google_maps_api_key = ENV['MELISSA_DATA_WEB_SMART_ID']
    #     end
    #
    #   Alternate way:
    #     MelissaData.web_smart_id        = ENV['MELISSA_DATA_WEB_SMART_ID']
    #     MelissaData.google_maps_api_key = ENV['MELISSA_DATA_WEB_SMART_ID']
    #
    # @param <api_key> [String] web smart id to use
    def configure
      yield self if block_given?
    end
  end
end
