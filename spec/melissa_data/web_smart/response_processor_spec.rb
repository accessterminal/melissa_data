require 'spec_helper'

describe MelissaData::WebSmart::ResponseProcessor do
  let(:client)            { MelissaData::WebSmart::Client.new }
  let(:property_response) { { result: { code: "YS01,YS03" } } }
  let(:address_response)  { { results: "AS01" } }
  let(:address_error_response)  { { results: "AC01,AC03,AS01" } }

  it "can get error codes" do
    property_codes = client.codes(property_response, 'property')
    address_codes  = client.codes(address_response, 'address')
    address_error_codes  = client.codes(address_error_response, 'address')
    expect(property_codes).to eq ["YS01", "YS03"]
    expect(address_codes).to eq ["AS01"]
    expect(address_error_codes).to eq ["AC01", "AC03", "AS01"]
  end

  context "handling success and errors" do
    it "can handle property success" do
      property_success_messages = client.codes_for(["YS01"], "property", "success")
      expect(property_success_messages).to eq ["FIPS/APN Match found"]
    end

    it "can handle address success" do
      address_success_messages = client.codes_for(["AS01"], "address", "success")
      expect(address_success_messages).to eq ["Address is valid and deliverable per postal agency guidelines."]

    end

    it "can handle property error" do
      property_error_messages = client.codes_for(["YE01"], "property", "error")
      expect(property_error_messages).to eq ["No FIPS/APN or AddressKey provided"]
    end

    it "can handle address error" do
      address_error_messages = client.codes_for(["AE01"], "address", "error")
      expect(address_error_messages).to eq ["Zip/Postal code does not exist or is improperly formatted."]
    end
  end

  it "can check if something has error codes" do
    expect(client.has_error_codes?(["AE01"])).to eq true
  end
end
