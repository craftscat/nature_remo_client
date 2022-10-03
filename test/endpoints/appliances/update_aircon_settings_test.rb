# frozen_string_literal: true

require 'test_helper'

class UpdateAirconSettingsTest < Minitest::Test
  def test_update_aircon_settings_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/aircon_settings')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               button: 'on',
               temperature: '24',
               operation_mode: 'cool',
               air_volume: '3',
               air_direction: 'auto'
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.update_aircon_settings(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', button: 'on', temperature: '24', operation_mode: 'cool', air_volume: '3', air_direction: 'auto')
  end

  def test_update_aircon_settings_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/aircon_settings')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               button: 'on',
               temperature: '24',
               operation_mode: 'cool',
               air_volume: '3',
               air_direction: 'auto'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_aircon_settings(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', button: 'on', temperature: '24', operation_mode: 'cool', air_volume: '3', air_direction: 'auto')
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_aircon_settings_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/aircon_settings')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               button: 'on',
               temperature: '24',
               operation_mode: 'cool',
               air_volume: '3',
               air_direction: 'auto'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_aircon_settings(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', button: 'on', temperature: '24', operation_mode: 'cool', air_volume: '3', air_direction: 'auto')
    end

    assert_equal 'execution expired', error.message
  end
end
