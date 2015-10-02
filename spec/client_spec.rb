require 'spec_helper'

describe MelissaData::WebSmart::Client do
  let(:client) { MelissaData::WebSmart::Client.new }

  it "does a thing" do
    result = MelissaData::WebSmart::Client.new.
             property("12071", "24-43-24-03-00022.0040")
    expect(result.keys.sort).to eq [:building, :current_deed, :current_sale, :lot,
                                    :owner, :owner_address, :parcel, :parsed_property_address,
                                    :prior_sale, :property_address, :record_id, :result,
                                    :square_footage, :values]
    result.keys.each do |key|
      expect(result[key]).to_not eq nil unless key == :record_id
    end
  end
end
