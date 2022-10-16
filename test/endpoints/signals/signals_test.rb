# frozen_string_literal: true

require 'test_helper'

class SignalsTest < Minitest::Test
  def test_signal_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(
             status: 200,
             body: ''
           )

    assert_equal '', @client.signals(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
  end

  def test_signal_auth_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 401, body: '{"code": 401001, "message": "認証エラー"}')

    error = assert_raises NatureRemo::Unauthorized do
      @client.signals(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
    end

    assert_equal 'request failed with status code 401, {"code": 401001, "message": "認証エラー"}', error.message
  end

  def test_signal_internal_server_error
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 500)

    error = assert_raises NatureRemo::InternalServerError do
      @client.signals(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
    end

    assert_equal 'request failed with status code 500, ', error.message
  end

  def test_signal_me_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_timeout
    error = assert_raises Faraday::ConnectionFailed do
      @client.signals(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
    end

    assert_equal 'execution expired', error.message
  end
end
