# frozen_string_literal: true

require 'test_helper'

class UpdateApplianceOrdersTest < Minitest::Test
  def test_update_appliance_orders_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliance_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               appliances: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_return(
             status: 200,
             body: ''
           )

    assert_equal '', @client.update_appliance_orders(appliance_ids: %w[db37aa9b-dbc8 4386-803e])
  end

  def test_update_appliance_orders_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliance_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               appliances: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_appliance_orders(appliance_ids: %w[db37aa9b-dbc8 4386-803e])
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_appliance_orders_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliance_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               appliances: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_appliance_orders(appliance_ids: %w[db37aa9b-dbc8 4386-803e])
    end

    assert_equal 'execution expired', error.message
  end
end
