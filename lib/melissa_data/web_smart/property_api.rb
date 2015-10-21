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
                                         OptPropertyDetail: "1" } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
      end

      def property_by_address_key(address_key:)
        resp = RestClient.get('https://property.melissadata.net/v3/REST/Service.svc/doLookup',
                             { params: { id: MelissaData.web_smart_id,
                                         AddressKey: address_key,
                                         OptPropertyDetail: "1" } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
      end

      def address(address:, city:, state:, zip:, country:)
        JSON.parse(RestClient.get('https://address.melissadata.net/v3/WEB/GlobalAddress/doGlobalAddress',
                                  { params: { id: MelissaData.web_smart_id,
                                              a1: address,
                                              loc: city,
                                              admarea: state,
                                              postal: zip,
                                              ctry: country },
                                    accept: :json,
                                    content_type: :json }))
      end
    end
  end
end
