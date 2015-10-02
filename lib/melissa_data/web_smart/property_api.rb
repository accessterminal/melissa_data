require 'rest-client'
require 'nokogiri'

module MelissaData 
  module WebSmart
    class PropertyAPI
      def property(fips, apn) 
        url = 'https://property.melissadata.net/v3/REST/Service.svc/doLookup'
        resp = RestClient.get(url,
                             { params: { id: ENV['MELISSA_DATA_WEB_SMART_ID'],
                                         fips: fips,
                                         apn: apn } })
        PropertyXMLParser.new(Nokogiri::XML(resp)).parse
      end
    end
  end
end
