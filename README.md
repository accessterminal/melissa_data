# Melissa Data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'melissa_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install melissa_data

## Usage

### Smart Web APIs

#### Property
There is a client included for the property API on Melissa. This requires very little.

You will need an environment variable: `MELISSA_DATA_WEB_SMART_ID`

Once you have this, you may use the following client. To instantiate a client:

```ruby
irb> client = MelissaData::WebSmart::Client.new
irb> client.property(some_fips_code, some_apn) 
# => property data
```

Data comes in the following form:

```json
{
    "record_id": null,
    "result": {
        "code": "YS01,YS03,YC01,GS05",
        "description": "FIPS/APN Match Found. Basic information returned."
    },
    "parcel": {
        "fips_code": "12071",
        "fips_sub_code": null,
        "unformatted_apn": null,
        "apn_sequence_no": null,
        "formatted_apn": "24-43-24-03-00022.0040",
        "original_apn": null,
        "census_tract": null,
        "zoning": null,
        "range": null,
        "township": null,
        "section": null,
        "quarter_section": null,
        "homestead_exempt": null,
        "absentee_owner_code": null,
        "land_use_code": null,
        "county_land_use1": null,
        "county_land_use2": null,
        "property_indicator_code": null,
        "municipality_name": null,
        "view_code": null,
        "location_influence_code": null,
        "number_of_buildings": null
    },
    "property_address": {
        "address": "8351 Bartholomew Dr",
        "city": "North Fort Myers",
        "state": "FL",
        "zip": "33917-1758",
        "address_key": "33917175851",
        "latitude": "26.72156",
        "longitude": "-81.85911"
    },
    "parsed_property_address": {
        "range": "8351",
        "pre_directional": null,
        "street_name": "Bartholomew",
        "suffix": "Dr",
        "post_directional": null,
        "suite_name": null,
        "suite_range": null
    },
    "owner": {
        "corporate_owner": null,
        "name": "EDWARDS JOHN V",
        "name2": null,
        "unparsed_name1": null,
        "unparsed_name2": null,
        "phone": null,
        "phone_opt_out": null
    },
    "owner_address": {
        "address": null,
        "suite": null,
        "city": null,
        "state": null,
        "zip": null,
        "carrier_route": null,
        "matchcode": null,
        "mail_opt_out": null
    },
    "values": {
        "calculated_total_value": "17300",
        "calculated_land_value": null,
        "calculated_improvement_value": null,
        "calculated_total_value_code": null,
        "calculated_land_value_code": null,
        "calculated_improvement_value_code": null,
        "assessed_total_value": "17300",
        "assessed_land_value": null,
        "assessed_improvement_value": null,
        "market_total_value": null,
        "market_land_value": null,
        "market_improvement_value": null,
        "appraised_total_value": null,
        "appraised_land_value": null,
        "appraised_improvement_value": null,
        "tax_amount": "235.82",
        "tax_year": null
    },
    "current_sale": {
        "transaction_id": null,
        "document_year": null,
        "deed_category_code": null,
        "recording_date": null,
        "sale_date": "19920109",
        "sale_price": "69000",
        "sale_code": null,
        "seller_name": null,
        "multi_apn_code": null,
        "multi_apn_count": null,
        "residental_model": null
    },
    "current_deed": {
        "mortgage_amount": "68900",
        "mortgage_date": null,
        "mortgage_loan_type_code": null,
        "mortgage_deed_type_code": null,
        "mortgage_term_code": null,
        "mortgage_term": null,
        "mortgage_due_date": null,
        "mortgage_assumption_amount": null,
        "lender_code": null,
        "lender_name": null,
        "second_mortgage_amount": null,
        "second_mortgage_loan_type_code": null,
        "second_mortgage_deed_type_code": null
    },
    "prior_sale": {
        "transaction_id": null,
        "document_year": null,
        "deed_category_code": null,
        "recording_date": null,
        "sale_date": null,
        "sale_price": null,
        "sale_code": null,
        "transaction_code": null,
        "multi_apn_code": null,
        "multi_apn_count": null,
        "mortgage_amount": null,
        "deed_type_code": null
    },
    "lot": {
        "front_footage": null,
        "depth_footage": null,
        "acreage": "2.1491",
        "square_footage": "93615"
    },
    "square_footage": {
        "universal_building": null,
        "building_area_code": null,
        "building_area": null,
        "living_space": null,
        "ground_floor": null,
        "gross": null,
        "adjusted_gross": null,
        "basement": null,
        "garage_or_parking": null
    },
    "building": {
        "year_built": null,
        "effective_year_built": null,
        "bed_rooms": "0",
        "total_rooms": "0",
        "total_baths_calculated": null,
        "total_baths": "0.00",
        "full_baths": null,
        "half_baths": null,
        "one_quarter_baths": null,
        "three_quarter_baths": null,
        "bath_fixtures": null,
        "air_conditioning_code": null,
        "basement_code": null,
        "building_code": null,
        "improvement_code": null,
        "condition_code": null,
        "construction_code": null,
        "exterior_wall_code": null,
        "fireplace": null,
        "fireplaces": null,
        "fireplace_code": null,
        "foundation_code": null,
        "flooring_code": null,
        "roof_framing_code": null,
        "garage_code": null,
        "heating_code": null,
        "mobile_home": null,
        "parking_spaces": null,
        "parking_code": null,
        "pool": null,
        "pool_code": null,
        "quality_code": null,
        "roof_cover_code": null,
        "roof_type_code": null,
        "stories_code": null,
        "stories": null,
        "building_style_code": null,
        "units": null,
        "electricity_code": null,
        "fuel_code": null,
        "sewer_code": null,
        "water_code": null
    }
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/melissa_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

