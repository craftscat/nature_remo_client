# frozen_string_literal: true

require 'test_helper'

class EchonetLiteAppliancesTest < Minitest::Test
  def test_echonet_lite_appliances_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/echonetlite/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(
             status: 200,
             body: '{"id": "string", "location": {"latitude": 0, "longitude": 0, "radius": 0}, "name": "string", "users": [{"id": "string", "joined_at": "2023-07-29T19:15:03.669Z", "location_state": "string", "nickname": "string", "role": "string"}]}'
           )

    assert_equal '{"id": "string", "location": {"latitude": 0, "longitude": 0, "radius": 0}, "name": "string", "users": [{"id": "string", "joined_at": "2023-07-29T19:15:03.669Z", "location_state": "string", "nickname": "string", "role": "string"}]}', @client.echonet_lite_appliances
  end

  def test_echonet_lite_appliances_auth_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/echonetlite/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 401, body: '{"code": 401001, "message": "認証エラー"}')

    error = assert_raises NatureRemo::Unauthorized do
      @client.echonet_lite_appliances
    end

    assert_equal 'request failed with status code 401, {"code": 401001, "message": "認証エラー"}', error.message
  end

  def test_echonet_lite_appliances_internal_server_error
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/echonetlite/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 500)

    error = assert_raises NatureRemo::InternalServerError do
      @client.echonet_lite_appliances
    end

    assert_equal 'request failed with status code 500, ', error.message
  end

  def test_echonet_lite_appliances_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/echonetlite/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_timeout
    error = assert_raises Faraday::ConnectionFailed do
      @client.echonet_lite_appliances
    end

    assert_equal 'execution expired', error.message
  end
end
