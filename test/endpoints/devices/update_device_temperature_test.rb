# frozen_string_literal: true

require 'test_helper'

class UpdateDeviceTemperatureTest < Minitest::Test
  def test_update_device_temperature_offset_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6/temperature_offset')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               offset: 1
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.update_device_temperature_offset(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', offset: 1)
  end

  def test_update_device_temperature_offset_internal_server_errror
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6/temperature_offset')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               offset: 1
             }
           )
           .to_return(status: 500)

    error = assert_raises NatureRemo::InternalServerError do
      @client.update_device_temperature_offset(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', offset: 1)
    end

    assert_equal 'request failed with status code 500, ', error.message
  end

  def test_update_device_temperature_offset_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6/temperature_offset')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               offset: 1
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_device_temperature_offset(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', offset: 1)
    end

    assert_equal 'execution expired', error.message
  end
end
