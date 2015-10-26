require 'rest-client'
require 'nokogiri'
require 'json'

module MelissaData
  module WebSmart
    class PropertyAPI
      def property_by_apn(fips:, apn:)
        resp = RestClient.get('https://property.melissadata.net/v3/REST/Service.svc/doLookup',
                             { params: { id: MelissaData.web_smart_id,
                                         fips: fips,
                                         apn: apn,
                                         opt: "True" } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
      end

      def property_by_address_key(address_key:)
        resp = RestClient.get('https://property.melissadata.net/v3/REST/Service.svc/doLookup',
                             { params: { id: MelissaData.web_smart_id,
                                         AddressKey: address_key,
                                         opt: "True" } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
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
