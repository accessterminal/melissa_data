require 'spec_helper'

describe MelissaData::WebSmart::Client do
  let(:client) { MelissaData::WebSmart::Client.new }

  context 'getting property data' do
    it 'gets the proper response using the client for property with a fips and apn' do
      result = client.property_by_apn(apn: '24-43-24-03-00022.0040', fips: '12071')
      expect(result.keys.sort).to eq [:building, :current_deed, :current_sale, :lot, :owner,
                                      :owner_address, :parcel, :parsed_property_address,
                                      :prior_sale, :property_address, :record_id, :result,
                                      :square_footage, :success, :values]
      result.keys.each do |key|
        expect(result[key]).to_not eq nil unless key == :record_id
      end
    end

    it 'gets the proper response using the client for property with an address key' do
      result = client.property_by_address_key(address_key: "43420981399")
      [:building, :current_deed, :current_sale, :lot,
      :owner, :owner_address, :parcel, :parsed_property_address,
      :prior_sale, :property_address, :record_id, :result,
      :square_footage, :success, :values].each do |key|
        expect(result.keys.include? key).to eq true
      end

      result.keys.each do |key|
        expect(result[key]).to_not eq nil unless key == :record_id
      end
    end

    it 'can get address info' do
      resp = client.address(address: "158 Thomas Dr. Apt 2",
                            city: "Fremont",
                            state: "OH",
                            zip: "43420")
    [:address_extras, :address_key, :address_line1,
     :address_line2, :city, :company_name,
     :email_address, :melissa_address_key, :name_full,
     :phone_number, :postal_code, :record_extras,
     :record_id, :reserved, :results, :state].each do |key|
      expect(resp.keys.include? key).to eq true
     end

    end
  end

  context 'when handling errors and bad data' do
    it 'has a meaningful error if improper params are given' do
      expect { client.property_by_apn(apn: '12071' ) }.to raise_error(ArgumentError, /fips/)
      expect { client.property_by_address_key() }.to raise_error(ArgumentError, /address/)
    end
  end
end
