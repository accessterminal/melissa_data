require 'faraday'
require 'typhoeus'
require 'json'

module MelissaData
  module WebSmart
    class PropertyAPI
      USER_AGENT = "MelissaData-Rubygem/#{MelissaData::VERSION}"
      BASE_URL = 'https://property.melissadata.net'

      def default_connection(url = BASE_URL, json_headers: false)
        Faraday.new(url: url) do |conn|
          conn.response :logger
          conn.headers[:user_agent] = USER_AGENT

          if json_headers
            conn.headers['Content-Type'] = 'application/json'
            conn.headers['Accept'] = 'application/json'
          end

          conn.adapter :typhoeus
        end
      end

      def property_by_apn(fips:, apn:)
        raw = default_connection(BASE_URL).get '/v4/WEB/LookupProperty/', {
          id: MelissaData.web_smart_id,
          fips: fips,
          apn: apn,
          cols: 'GrpAll',
          addressKey: nil,
          format: 'json'
        }

        res = JSON.parse(raw.body).deep_transform_keys(&:underscore)
        res&.with_indifferent_access
      end

      def property_by_address_key(address_key:)
        raw = default_connection(BASE_URL).get '/v4/WEB/LookupProperty/', {
          id: MelissaData.web_smart_id,
          AddressKey: address_key,
          format: 'json'
        }

        res = JSON.parse(raw.body).deep_transform_keys(&:underscore)
        res&.with_indifferent_access
      end

      def address(address:, city:, state:, zip:, country:)
        raw = default_connection(BASE_URL, json_headers: true)
          .get '/v3/WEB/ContactVerify/doContactVerify', {
            id: MelissaData.web_smart_id,
            Actions: 'Check',
            a1: address,
            city: city,
            state: state,
            postal: zip,
            ctry: country,
            AdvancedAddressCorrection: 'on'
        }

        res = JSON.parse(raw.body).deep_transform_keys(&:underscore)
        res&.with_indifferent_access[:records]&.first
      end
    end
  end
end
