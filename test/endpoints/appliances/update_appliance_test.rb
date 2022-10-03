# frozen_string_literal: true

require 'test_helper'

class UpdateApplianceTest < Minitest::Test
  def test_update_appliance_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'name',
               image: 'ico_io'
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.update_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', nickname: 'name', image: 'ico_io')
  end

  def test_update_appliance_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'wrong name',
               image: 'ico_io'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', nickname: 'wrong name', image: 'ico_io')
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_appliance_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'name',
               image: 'ico_io'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.update_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6', nickname: 'name', image: 'ico_io')
    end

    assert_equal 'execution expired', error.message
  end
end
