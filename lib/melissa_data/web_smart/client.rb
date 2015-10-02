module MelissaData
  module WebSmart
    class Client
      def property(fips, apn)
        MelissaData::WebSmart::PropertyAPI.new.property(fips, apn)
      end
    end
  end
end
