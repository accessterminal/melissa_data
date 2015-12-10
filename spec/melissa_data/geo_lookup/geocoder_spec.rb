require 'spec_helper'

describe MelissaData::GeoLookup::Geocoder do
  before do allow_any_instance_of(MelissaData::GeoLookup::Geocoder)
             .to receive(:address_to_coordinates)
             .and_return({ latitude: 41.377552, longitude: -83.13062699999999 })
  end

  it "can turn an address into a lat/long coordinates" do
    geocoder = MelissaData::GeoLookup::Geocoder
    res = geocoder.address_to_coordinates("159 thomas drive, fremont, ohio")
    expected = { latitude: 41.377552, longitude: -83.13062699999999 }
    expect(res).to eq expected
  end
end
