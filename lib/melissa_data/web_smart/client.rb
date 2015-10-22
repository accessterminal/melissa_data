module MelissaData
  module WebSmart
    class Client
      include MelissaData::WebSmart::ResponseProcessor
      include MelissaData::WebSmart::Formatters

      def initialize
        @client = MelissaData::WebSmart::PropertyAPI.new
      end

      def property_by_apn(fips:, apn:)
        process(@client.property_by_apn(fips: fips, apn: apn), 'property')
      end

      def property_by_address_key(address_key:)
        process(@client.property_by_address_key(address_key: address_key), 'property')
      end

      def address(address:, city:, state:, zip:, country: "USA")
        resp = viperize_hash(@client.address(address: address,
                                             city: city,
                                             state: state,
                                             zip: zip,
                                             country: country))
        process(resp, 'address')
      end
    end
  end
end
