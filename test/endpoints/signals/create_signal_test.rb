# frozen_string_literal: true

require 'test_helper'

class CreateSignalTest < Minitest::Test
  def test_create_signal_success
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'signal',
               image: 'ico_io',
               message: '{"freq":38,"data":[2523,2717,786,903,777,924,763,1964,768,1958,769,1955,772,1953,773,914,770,902,786,54147,2523,2721,782,920,761,924,773,1936,779,1948,784,1957,768,1942,784,921,758,924,772],"format":"us"}'
             }
           )
           .to_return(
             status: 200,
             body: ''
           )

    assert_equal '', @client.create_signal(
      appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
      name: 'signal',
      image: 'ico_io',
      message: '{"freq":38,"data":[2523,2717,786,903,777,924,763,1964,768,1958,769,1955,772,1953,773,914,770,902,786,54147,2523,2721,782,920,761,924,773,1936,779,1948,784,1957,768,1942,784,921,758,924,772],"format":"us"}'
    )
  end

  def test_create_signal_failure
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'signal',
               image: 'ico_io',
               message: 'wrong signal'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.create_signal(
        appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
        name: 'signal',
        image: 'ico_io',
        message: 'wrong signal'
      )
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_create_signal_timeout
    @client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               name: 'signal',
               image: 'ico_io',
               message: '{"freq":38,"data":[2523,2717,786,903,777,924,763,1964,768,1958,769,1955,772,1953,773,914,770,902,786,54147,2523,2721,782,920,761,924,773,1936,779,1948,784,1957,768,1942,784,921,758,924,772],"format":"us"}'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      @client.create_signal(
        appliance_id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
        name: 'signal',
        image: 'ico_io',
        message: '{"freq":38,"data":[2523,2717,786,903,777,924,763,1964,768,1958,769,1955,772,1953,773,914,770,902,786,54147,2523,2721,782,920,761,924,773,1936,779,1948,784,1957,768,1942,784,921,758,924,772],"format":"us"}'
      )
    end

    assert_equal 'execution expired', error.message
  end
end
