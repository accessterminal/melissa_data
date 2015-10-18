require 'melissa_data'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do

    stub_request(:get, /GlobalAddress/).
    with(:headers => {'Accept'=>'*/*; q=0.5, application/xml',
                      'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200,
              :body => File.read("spec/fixtures/address_response.xml"),
              :headers => {})

    stub_request(:get, /property/).
    with(:headers => {'Accept'=>'*/*; q=0.5, application/xml',
                      'Accept-Encoding'=>'gzip, deflate',
                      'User-Agent'=>'Ruby'}).
    to_return(:status => 200,
              :body => File.read("spec/fixtures/fips_apn_response.xml"),
              :headers => {})

    stub_request(:get, "https://property.melissadata.net/v3/REST/Service.svc/doLookup?AddressKey=4342099&id=").
    with(:headers => { 'Accept'=>'*/*; q=0.5, application/xml',
                       'Accept-Encoding'=>'gzip, deflate',
                       'User-Agent'=>'Ruby'}).
    to_return(:status => 200,
              :body => File.read("spec/fixtures/address_error_response.xml"),
              :headers => {})
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
