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

    stub_request(:get, "/4342099/").
    with(:headers => { 'Accept'=>'*/*; q=0.5, application/xml',
                       'Accept-Encoding'=>'gzip, deflate',
                       'User-Agent'=>'Ruby'}).
    to_return(:status => 200,
              :body => File.read("spec/fixtures/address_error_response.xml"),
              :headers => {})

    stub_request(:get, /personator/).
    with(:headers => {'Accept'=>'application/json',
                      'Accept-Encoding'=>'gzip, deflate',
                      'Content-Type'=>'application/json',
                      'User-Agent'=>'Ruby'}).
    to_return(:status => 200,
              :body => File.read("spec/fixtures/address_success_response.json"),
              :headers => {})

  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
