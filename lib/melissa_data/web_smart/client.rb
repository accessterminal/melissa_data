module MelissaData
  module WebSmart
    class Client
      include MelissaData::WebSmart::ResponseProcessor
      include MelissaData::WebSmart::Formatters

      def initialize
        @client = MelissaData::WebSmart::PropertyAPI.new
      end

      def property_by_apn(fips:, apn:)
        res = process(@client.property_by_apn(fips: fips, apn: apn), 'property')
        add_coordinates(res) unless MelissaData::GeoLookup::Geocoder.coordinates? res
        res
      end

      def property_by_address_key(address_key:)
        res = process(@client.property_by_address_key(address_key: address_key), 'property')
        add_coordinates(res) unless MelissaData::GeoLookup::Geocoder.coordinates? res
        res
      end

      def address(address:, city:, state:, zip:, country: "USA")
        resp = viperize_hash(@client.address(address: address,
                                             city: city,
                                             state: state,
                                             zip: zip,
                                             country: country))
        process(resp, 'address')
      end

      def add_coordinates(response)
        addr  = response[:property_address][:address]
        city  = response[:property_address][:city]
        state = response[:property_address][:state]
        zip   = response[:property_address][:zip]
        full_address = "#{addr}, #{city}, #{state}, #{zip}"
        MelissaData::GeoLookup::Geocoder
          .address_to_coordinates(full_address)
      end
    end
  end
end
