require "melissa_data/version"
require "melissa_data/web_smart/xml"
require "melissa_data/web_smart/response_processor"
require "melissa_data/web_smart/client"
require "melissa_data/web_smart/property_api"
require "melissa_data/config"
require "melissa_data/geo_lookup/geocoder"

require 'rest-client'
require 'nokogiri'
require 'geokit'

module MelissaData
  include MelissaData::Config
end
