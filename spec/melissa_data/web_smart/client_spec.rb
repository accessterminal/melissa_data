require 'spec_helper'

describe MelissaData::WebSmart::Client do
  let(:client) { MelissaData::WebSmart::Client.new }
  before(:each) { MelissaData.web_smart_id = '113592403' }

  context "getting property data" do
    it "gets the proper response using the client for property with a fips and apn" do
      result = client.property_by_apn(apn: "24-43-24-03-00022.0040", fips: "12071")
      expect(result.keys.sort).to eq [:building, :current_deed, :current_sale, :lot, :owner,
                                      :owner_address, :parcel, :parsed_property_address,
                                      :prior_sale, :property_address, :record_id, :result,
                                      :square_footage, :success, :values]
      result.keys.each do |key|
        expect(result[key]).to_not eq nil unless key == :record_id
      end
    end

    it "gets the proper response using the client for property with an address key" do
      address_key = client.address(address: "158 Thomas Drive",
                           city: "Fremont",
                           state: "Ohio",
                           zip: "43420")[:address_key]

      result = client.property_by_address_key(address_key: address_key)
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
  end

  context "getting address data for property API" do
    it "can verify address data" do
      result = client.address(address: "158 Thomas Drive",
                      city: "Fremont",
                      state: "Ohio",
                      zip: "43420")
      [:record_id, :results, :formatted_address, :organization, :address_line1, :address_line2,
       :address_line3, :address_line4, :address_line5, :address_line6, :address_line7, :address_line8,
       :sub_premises, :double_dependent_locality, :dependent_locality, :locality, :sub_administrative_area,
       :administrative_area, :postal_code, :address_type, :address_key, :sub_national_area, :country_name,
       :country_iso3166_1_alpha2, :country_iso3166_1_alpha3, :country_iso3166_1_numeric, :thoroughfare,
       :thoroughfare_pre_direction, :thoroughfare_leading_type, :thoroughfare_name, :thoroughfare_trailing_type,
       :thoroughfare_post_direction, :dependent_thoroughfare, :dependent_thoroughfare_pre_direction, 
       :dependent_thoroughfare_leading_type, :dependent_thoroughfare_name, :dependent_thoroughfare_trailing_type,
       :dependent_thoroughfare_post_direction, :building, :premises_type, :premises_number, :sub_premises_type,
       :sub_premises_number, :post_box, :latitude, :longitude].each do |key|
        expect(result.keys.include? key).to eq true
      end
     result.keys.each do |key|
       expect(result[key]).not_to eq nil
     end
    end
  end

  context "when handling errors and bad data" do
    it "has a meaningful error if improper params are given" do
      expect { client.property_by_apn(apn: "12071" ) }.to raise_error(ArgumentError, /fips/)
      expect { client.address(city: "gibsonburg" ) }.to raise_error(ArgumentError, /state/)
    end
  end
end
