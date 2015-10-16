module MelissaData
  module WebSmart
    class Client
      include MelissaData::WebSmart::ResponseProcessor

      def initialize
        @client = MelissaData::WebSmart::PropertyAPI.new
      end

      def property_by_apn(fips:, apn:)
        process_property(@client.property_by_apn(fips: fips, apn: apn))
      end

      def property_by_address_key(address_key:)
        process_property(@client.property_by_address_key(address_key: address_key))
      end

      def address(address:, city:, state:, zip:, country: "USA")
        resp = @client.address(address: address, city: city, state: state,
                        zip: zip, country: country)
      end
    end
  end
end
