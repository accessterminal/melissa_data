require 'spec_helper'

describe MelissaData::WebSmart::Client do
  let(:client) { MelissaData::WebSmart::Client.new }

  it "gets the proper response using the client for property with a fips and apn" do
    result = MelissaData::WebSmart::Client.new.
             property(apn: "24-43-24-03-00022.0040", fips: "12071")
    expect(result.keys.sort).to eq [:building, :current_deed, :current_sale, :lot,
                                    :owner, :owner_address, :parcel, :parsed_property_address,
                                    :prior_sale, :property_address, :record_id, :result,
                                    :square_footage, :values]
    result.keys.each do |key|
      expect(result[key]).to_not eq nil unless key == :record_id
    end
  end

  it "has a meaningful error if improper params are given" do
    client = MelissaData::WebSmart::Client.new
    expect { client.property(apn: "12071" ) }.to raise_error(ArgumentError, /fips/)
  end
end
