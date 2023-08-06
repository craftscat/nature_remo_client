# frozen_string_literal: true

require 'test_helper'

class SetEchonetLitePropertyTest < Minitest::Test
  def test_set_echonet_lite_property_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/echonetlite/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/set')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               EPC: 'cf',
               Val: '000000FF'
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.set_echonet_lite_property(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', epc: 'cf', val: '000000FF')
  end

  def test_set_echonet_lite_property_auth_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/echonetlite/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/set')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               EPC: 'cf',
               Val: '000000FF'
             }
           )
           .to_return(status: 401, body: '{"code": 401001, "message": "認証エラー"}')

    error = assert_raises NatureRemo::Unauthorized do
      @client.set_echonet_lite_property(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', epc: 'cf', val: '000000FF')
    end

    assert_equal 'request failed with status code 401, {"code": 401001, "message": "認証エラー"}', error.message
  end

  def test_set_echonet_lite_property_internal_server_error
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/echonetlite/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/set')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               EPC: 'cf',
               Val: '000000FF'
             }
           )
           .to_return(status: 500)

    error = assert_raises NatureRemo::InternalServerError do
      @client.set_echonet_lite_property(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', epc: 'cf', val: '000000FF')
    end

    assert_equal 'request failed with status code 500, ', error.message
  end

  def test_set_echonet_lite_property_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/echonetlite/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/set')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               EPC: 'cf',
               Val: '000000FF'
             }
           )
           .to_timeout
    error = assert_raises Faraday::ConnectionFailed do
      @client.set_echonet_lite_property(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', epc: 'cf', val: '000000FF')
    end

    assert_equal 'execution expired', error.message
  end
end
