require 'spec_helper'

describe MelissaData::WebSmart::ResponseProcessor do
  let(:client) { MelissaData::WebSmart::Client.new }
  let(:good_response) { { result: { code: "YS01,YS04" } } }
  let(:bad_response) { { result: { code: "YE01" } } }

  context "on processing a property" do
    it "has the property success codes and their meanings" do
      success_codes = { YS01: "FIPS/APN Match found",
                YS02: "AddressKey Match found",
                YS03: "Basic information returned",
                YS04: "Detailed information returned" }

      expect(client.property_success_codes).to eq success_codes
    end

    it "has the property error codes and their meanings" do
      error_codes = { YE01: "No FIPS/APN or AddressKey provided",
                      YE02: "No match found",
                      YE03: "Invalid FIPS/APN or AddressKey provided" }
      expect(client.property_error_codes).to eq error_codes
    end

    it "can get error codes" do
      expect(client.codes(good_response)).to eq ["YS01", "YS04"]
    end

    it "can properly check for error codes" do
      codes = client.codes(bad_response)
      expect(client.has_error_codes?(codes)).to eq true
    end

    it "can get codes of each type's message (error/success)" do
      good_codes = client.codes(good_response)
      bad_codes = client.codes(bad_response)
      successes = client.codes_for(good_codes, 'success')
      errors = client.codes_for(bad_codes, 'error')
      expect(successes).to eq ["FIPS/APN Match found", "Detailed information returned"]
      expect(errors).to eq  ["No FIPS/APN or AddressKey provided"]
    end

    it "can process an entire response properly" do
      good_expected = { :result => { :code => "YS01,YS04" }, :success => ["FIPS/APN Match found", "Detailed information returned"] }
      bad_expected = { :errors => ["No FIPS/APN or AddressKey provided"] }
      expect(client.process_property(good_response)).to eq good_expected
      expect(client.process_property(bad_response)).to eq bad_expected
    end
  end
end
