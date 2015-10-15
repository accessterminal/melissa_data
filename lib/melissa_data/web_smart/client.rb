module MelissaData
  module WebSmart
    class Client
      def initialize
        @client = MelissaData::WebSmart::PropertyAPI.new
      end

      def property_by_apn(fips:, apn:)
        @client.property_by_apn(fips: fips, apn: apn)
      end

      def property_by_address_key(address_key:)
        @client.property_by_address_key(address_key: address_key)
      end

      def address(address:, city:, state:, zip:, country: "USA")
        @client.address(address: address, city: city, state: state,
                        zip: zip, country: country)
      end
    end
  end
end
