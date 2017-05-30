module MelissaData
  module WebSmart
    class Client
      include MelissaData::WebSmart::ResponseProcessor
      include MelissaData::WebSmart::Formatters

      def initialize
        @client = MelissaData::WebSmart::PropertyAPI.new
      end

      def property_by_apn(fips:, apn:)
        @response = process(@client.property_by_apn(fips: fips, apn: apn), 'property')
        resolve_response
      end

      def property_by_address_key(address_key:)
        @response = process(@client.property_by_address_key(address_key: address_key), 'property')
        resolve_response
      end

      def success?
        !@response.key?(:errors)
      end

      def resolve_response
        return @response unless success?
        add_coordinates(@response) unless MelissaData::GeoLookup::Geocoder.coordinates? @response
        @response
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
        addr  = response.dig(:property_address, :address)
        city  = response.dig(:property_address, :city)
        state = response.dig(:property_address, :state)
        zip   = response.dig(:property_address, :zip)
        full_address = "#{addr}, #{city}, #{state}, #{zip}"
        MelissaData::GeoLookup::Geocoder
          .address_to_coordinates(full_address)
      end
    end
  end
end
