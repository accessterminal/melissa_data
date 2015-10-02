require 'rest-client'
require 'nokogiri'

module MelissaData
  module WebSmart
    class PropertyAPI
      def property(fips, apn)
        resp = RestClient.get('https://property.melissadata.net/v3/REST/Service.svc/doLookup',
                             { params: { id: MelissaData.web_smart_id,
                                         fips: fips,
                                         apn: apn } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
      end
    end
  end
end
