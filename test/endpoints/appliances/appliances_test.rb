# frozen_string_literal: true

require 'test_helper'

class AppliancesTest < Minitest::Test
  def test_appliances_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(
             status: 200,
             body: "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"string\"\n}"
           )

    assert_equal "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"string\"\n}", @client.appliances
  end

  def test_appliances_auth_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 401, body: '{"code": 401001, "message": "認証エラー"}')

    error = assert_raises NatureRemo::Unauthorized do
      @client.appliances
    end

    assert_equal 'request failed with status code 401, {"code": 401001, "message": "認証エラー"}', error.message
  end

  def test_appliances_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:get, 'https://api.nature.global/1/appliances')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_timeout
    error = assert_raises Faraday::ConnectionFailed do
      @client.appliances
    end

    assert_equal 'execution expired', error.message
  end
end
