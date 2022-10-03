# frozen_string_literal: true

require 'test_helper'

class UpdateSignalOrdersTest < Minitest::Test
  def test_update_signal_orders_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signal_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               signals: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_return(
             status: 200,
             body: ''
           )

    assert_equal '', @client.update_signal_orders(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', signal_ids: %w[db37aa9b-dbc8 4386-803e])
  end

  def test_update_signal_orders_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signal_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               signals: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_signal_orders(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', signal_ids: %w[db37aa9b-dbc8 4386-803e])
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_signal_orders_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signal_orders')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               signals: %w[db37aa9b-dbc8 4386-803e]
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_signal_orders(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', signal_ids: %w[db37aa9b-dbc8 4386-803e])
    end

    assert_equal 'execution expired', error.message
  end
end