module MelissaData
  module GeoLookup
    module Geocoder
      extend self

      def address_to_coordinates(address)
        if authenticate
          lat_long = Geokit::Geocoders::GoogleGeocoder.geocode(address)
            .ll
            .split(",")
            .map(&:to_f)
            { latitude: lat_long.first, longitude: lat_long.last }
        end
      end

      def coordinates?(response)
        if !response[:errors]
          lat = response.fetch(:property_address)[:latitude]
          long =response.fetch(:property_address)[:longitude]
          lat != nil && long != nil
        else
          false
        end
      end

      def authenticate
        Geokit::Geocoders::GoogleGeocoder.api_key = MelissaData.google_maps_api_key
        Geokit::Geocoders::GoogleGeocoder.api_key
      end

      def authenticate
        Geokit::Geocoders::GoogleGeocoder.api_key = MelissaData.google_maps_api_key
        Geokit::Geocoders::GoogleGeocoder.api_key
      end
    end
  end
end
