module MelissaData
  module WebSmart
    module ResponseProcessor
      require 'yaml'
      CODE_TYPES = [:property, :address]

      def process(response, resp_type)
        codes = codes(response, resp_type)
        if has_error_codes?(codes)
          {
            errors: codes_for(codes, resp_type, 'error'),
            error_codes: map_codes_for(codes, resp_type, 'error')
          }
        else
          response.merge!(success: codes_for(codes, resp_type, 'success'))
        end
      end

      def codes_for(codes, resp_type, code_type)
        codes.map do |code|
          YAML.load(File.read("config/#{resp_type}_#{code_type}_codes.yml")).values.first[code.to_s]
        end.compact
      end

      def map_codes_for(codes, resp_type, code_type)
        codes.each_with_object([]) do |code, res|
          res << { code: code.to_s, description: YAML.load(File.read("config/#{resp_type}_#{code_type}_codes.yml")).values.first[code.to_s] }
        end.compact
      end

      def codes(response, resp_type)
        case resp_type
        when 'property'
          response[:result][:code].split(",")
        when 'address'
          response[:results].split(",")
        end
      end

      def has_error_codes?(codes)
        !codes.select { |code| error_codes.include? code.to_sym }.empty?
      end

      def error_codes
        error_code_strings = CODE_TYPES.map { |t| File.read("config/#{t}_error_codes.yml") }
        error_code_strings.map { |c| YAML.load(c) }.flat_map { |code| code.values.first.keys.map(&:to_sym) }
      end
    end
  end
end
