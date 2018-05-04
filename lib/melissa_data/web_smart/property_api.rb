require 'rest-client'
require 'json'

module MelissaData
  module WebSmart
    class PropertyAPI
      def property_by_apn(fips:, apn:)
        resp = RestClient.get('https://property.melissadata.net/v4/WEB/LookupProperty/',
                             { params: { id: MelissaData.web_smart_id,
                                         fips: fips,
                                         apn: apn,
                                         format: 'json' } })
        res = JSON.parse(resp.body).deep_transform_keys(&:underscore)
        res&.with_indifferent_access
      end

      def property_by_address_key(address_key:)
        resp = RestClient.get('https://property.melissadata.net/v4/WEB/LookupProperty/',
                             { params: { id: MelissaData.web_smart_id,
                                         AddressKey: address_key,
                                         format: 'json' } })
        res = JSON.parse(resp.body).deep_transform_keys(&:underscore)
        res&.with_indifferent_access
      end

      def address(address:, city:, state:, zip:, country:)
        resp = JSON.parse(RestClient.get("https://personator.melissadata.net/v3/WEB/ContactVerify/doContactVerify",
                                         { params: { id: MelissaData.web_smart_id,
                                                     Actions: "Check",
                                                     a1: address,
                                                     city: city,
                                                     state: state,
                                                     postal: zip,
                                                     ctry: country,
                                                     AdvancedAddressCorrection: "on",},
                                           accept: :json,
                                           content_type: :json }))
        resp["Records"].first
      end
    end
  end
end
