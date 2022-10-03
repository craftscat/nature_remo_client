# frozen_string_literal: true

require 'test_helper'

class DeleteApplianceTest < Minitest::Test
  def test_delete_appliance_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/delete')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(
             status: 200,
             body: '{}'
           )

    assert_equal '{}', @client.delete_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
  end

  def test_delete_appliance_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/delete')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.delete_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_delete_appliance_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/delete')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.delete_appliance(appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6')
    end

    assert_equal 'execution expired', error.message
  end
end
