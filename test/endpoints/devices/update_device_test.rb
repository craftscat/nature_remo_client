# frozen_string_literal: true

require 'test_helper'

class UpdateDeviceTest < Minitest::Test
  def test_update_device_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'name'
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.update_device(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', name: 'name')
  end

  def test_update_device_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'wrong name'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_device(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', name: 'wrong name')
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_device_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'name'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_device(device_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', name: 'name')
    end

    assert_equal 'execution expired', error.message
  end
end
