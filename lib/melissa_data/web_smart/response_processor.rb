module MelissaData
  module WebSmart
    module ResponseProcessor
      def process_property(response)
        codes = codes(response)

        if has_error_codes?(codes)
          { errors: codes_for(codes, 'error') }
        else
          response.merge!(success: codes_for(codes, 'success'))
        end
      end

      def codes_for(codes, type)
        codes.map { |c| method("property_#{type}_codes").call[c.to_sym] }.compact
      end

      def codes(response)
        response[:result][:code].split(",")
      end

      def has_error_codes?(codes)
        !codes.select { |c| c if property_error_codes.keys.include? c.to_sym }.empty?
      end

      def property_success_codes
        { YS01: "FIPS/APN Match found",
          YS02: "AddressKey Match found",
          YS03: "Basic information returned",
          YS04: "Detailed information returned" }
      end

       def property_error_codes
         { YE01: "No FIPS/APN or AddressKey provided",
           YE02: "No match found",
           YE03: "Invalid FIPS/APN or AddressKey provided" }
      end
    end
  end
end
