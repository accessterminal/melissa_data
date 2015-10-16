# Melissa Data

[![Build Status](https://travis-ci.org/cometaworks/melissa_data.svg)](https://travis-ci.org/cometaworks/melissa_data)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'melissa_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install melissa_data

## Configuration

There are two ways to configure the gem.

### Block configuration

```ruby
MelissaData.configure do |config|
  config.web_smart_id = ENV['MELISSA_DATA_WEB_SMART_ID']
end
```

### One-liner

```ruby
MelissaData.web_smart_id = ENV['MELISSA_DATA_WEB_SMART_ID']
```
## Usage

### Smart Web APIs

#### Property
There is a client included for the property API on Melissa. This requires very little.
You will need a `MelissaData Web Smart ID`.

#### Quick Use
Once you have these, you may use the following client. To instantiate a client:

```ruby
irb> MelissaData.web_smart_id = ENV['MELISSA_DATA_WEB_SMART_ID']
irb> client = MelissaData::WebSmart::Client.new
irb> client.property_by_apn(fips: some_fips_code, apn: some_apn)
# => your property data
# since it uses keyword arguments, order does not matter
irb> client.property_by_apn(apn: some_apn, fips: some_fips_code)
# => your property data

# You can also look up an address code and get its `address_key` instead of using
# an apn and fips code
irb> key = client.address(address: "158 Thomas Dr", city: "Fremont", state: "Ohio", zip: "43420")[:address_key]
irb> client.property_by_address_key(key)
# => your property data
```

#### Property Client

The following are the main keys returned by the client for a property request:

```
record_id
result
parcel
property_address
parsed_property_address
owner
owner_address
values
current_sale
current_deed
prior_sale
lot
square_footage
building
success
```

To request a property's information, you must go through one of two processes. In order to request a property
by address, there are two steps.

Prepare a client

```ruby
irb> client = MelissaData::WebSmart::Client.new
```

And next, we call `Client#address` with the keys `address`, `city`, `state`, `zip`, and optionally `country`,
which defaults to `US` in order to get an address key. If we do not have a `FIPS` and `APN` for the property,
we must go through this step in order to get the key to pass to the `Client#property` method.

```ruby
irb. address_key = client.address(address: '158 thomas dr', city: 'fremont', state: 'ohio', zip: '43420')
```

And now we can call the regular `Client#property` method to get the enriched data for the parcel.

```ruby
irb> client.property_by_address_key(address_key: address_key)
# =>
{:record_id=>nil,
    :result=>
    {:code=>"YS01,YS03,YC01,GS05",
     :description=> "FIPS/APN Match Found. Basic information returned."},
  :parcel=>
    {:fips_code=>"12071",
    :fips_sub_code=>nil,
    :unformatted_apn=>nil,
    :apn_sequence_no=>nil,
    :formatted_apn=>"24-43-24-03-00022.0040",
    :original_apn=>nil,
    :census_tract=>nil,
    :zoning=>nil,
    :range=>nil,
    :township=>nil,
    :section=>nil,
    :quarter_section=>nil,
    :homestead_exempt=>nil,
    :absentee_owner_code=>nil,
    :land_use_code=>nil,
    :county_land_use1=>nil,
    :county_land_use2=>nil,
    :property_indicator_code=>nil,
    :municipality_name=>nil,
    :view_code=>nil,
    :location_influence_code=>nil,
    :number_of_buildings=>nil},
    :property_address=>
  {:address=>"8351 Bartholomew Dr",
    :city=>"North Fort Myers",
    :state=>"FL",
    :zip=>"33917-1758",
    :address_key=>"33917175851",
    :latitude=>"26.72156",
    :longitude=>"-81.85911"},
    :parsed_property_address=>
  {:range=>"8351",
    :pre_directional=>nil,
    :street_name=>"Bartholomew",
   :suffix=>"Dr",
   :post_directional=>nil,
   :suite_name=>nil,
   :suite_range=>nil},
 :owner=>
  {:corporate_owner=>nil,
   :name=>"EDWARDS JOHN V",
   :name2=>nil,
   :unparsed_name1=>nil,
   :unparsed_name2=>nil,
   :phone=>nil,
   :phone_opt_out=>nil},
 :owner_address=>
  {:address=>nil,
   :suite=>nil,
   :city=>nil,
   :state=>nil,
   :zip=>nil,
   :carrier_route=>nil,
   :matchcode=>nil,
   :mail_opt_out=>nil},
 :values=>
  {:calculated_total_value=>"17300",
   :calculated_land_value=>nil,
   :calculated_improvement_value=>nil,
   :calculated_total_value_code=>nil,
   :calculated_land_value_code=>nil,
   :calculated_improvement_value_code=>nil,
   :assessed_total_value=>"17300",
   :assessed_land_value=>nil,
   :assessed_improvement_value=>nil,
   :market_total_value=>nil,
   :market_land_value=>nil,
   :market_improvement_value=>nil,
   :appraised_total_value=>nil,
   :appraised_land_value=>nil,
   :appraised_improvement_value=>nil,
   :tax_amount=>"235.82",
   :tax_year=>nil},
 :current_sale=>
  {:transaction_id=>nil,
   :document_year=>nil,
   :deed_category_code=>nil,
   :recording_date=>nil,
   :sale_date=>"19920109",
   :sale_price=>"69000",
   :sale_code=>nil,
   :seller_name=>nil,
   :multi_apn_code=>nil,
   :multi_apn_count=>nil,
   :residental_model=>nil},
 :current_deed=>
  {:mortgage_amount=>"68900",
   :mortgage_date=>nil,
   :mortgage_loan_type_code=>nil,
   :mortgage_deed_type_code=>nil,
   :mortgage_term_code=>nil,
   :mortgage_term=>nil,
   :mortgage_due_date=>nil,
   :mortgage_assumption_amount=>nil,
   :lender_code=>nil,
   :lender_name=>nil,
   :second_mortgage_amount=>nil,
   :second_mortgage_loan_type_code=>nil,
   :second_mortgage_deed_type_code=>nil},
 :prior_sale=>
  {:transaction_id=>nil,
   :document_year=>nil,
   :deed_category_code=>nil,
   :recording_date=>nil,
   :sale_date=>nil,
   :sale_price=>nil,
   :sale_code=>nil,
   :transaction_code=>nil,
   :multi_apn_code=>nil,
   :multi_apn_count=>nil,
   :mortgage_amount=>nil,
   :deed_type_code=>nil},
 :lot=>
  {:front_footage=>nil,
   :depth_footage=>nil,
   :acreage=>"2.1491",
   :square_footage=>"93615"},
 :square_footage=>
  {:universal_building=>nil,
   :building_area_code=>nil,
   :building_area=>nil,
   :living_space=>nil,
   :ground_floor=>nil,
   :gross=>nil,
   :adjusted_gross=>nil,
   :basement=>nil,
   :garage_or_parking=>nil},
 :building=>
  {:year_built=>nil,
   :effective_year_built=>nil,
   :bed_rooms=>"0",
   :total_rooms=>"0",
   :total_baths_calculated=>nil,
   :total_baths=>"0.00",
   :full_baths=>nil,
   :half_baths=>nil,
   :one_quarter_baths=>nil,
   :three_quarter_baths=>nil,
   :bath_fixtures=>nil,
   :air_conditioning_code=>nil,
   :basement_code=>nil,
   :building_code=>nil,
   :improvement_code=>nil,
   :condition_code=>nil,
   :construction_code=>nil,
   :exterior_wall_code=>nil,
   :fireplace=>nil,
   :fireplaces=>nil,
   :fireplace_code=>nil,
   :foundation_code=>nil,
   :flooring_code=>nil,
   :roof_framing_code=>nil,
   :garage_code=>nil,
   :heating_code=>nil,
   :mobile_home=>nil,
   :parking_spaces=>nil,
   :parking_code=>nil,
   :pool=>nil,
   :pool_code=>nil,
   :quality_code=>nil,
   :roof_cover_code=>nil,
   :roof_type_code=>nil,
   :stories_code=>nil,
   :stories=>nil,
   :building_style_code=>nil,
   :units=>nil,
   :electricity_code=>nil,
   :fuel_code=>nil,
   :sewer_code=>nil,
   :water_code=>nil},
 :success=>
  ["FIPS/APN Match found", "Basic information returned"]}
}
```

The alternative method is used if you have a `FIPS` and `APN` available. This is `Client#property_by_apn`.

```ruby
irb> client.property_by_apn(apn: 'my_apn', fips: 'my_fips')
# => see above return format, it is identical
```

There is an `error` key returned in a hash with the reasons for the failure if an error occurs.
If there is not an error, there is a `success` key added with some basic logging and information such as:

```
["FIPS/APN Match found", "Basic information returned"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/melissa_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
