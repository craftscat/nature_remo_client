# frozen_string_literal: true

require 'test_helper'

class ClientTest < Minitest::Test
  def test_user_success
    @client = NatureRemo::Client.new('sometoken')
    WebMock.stub_request(:get, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => 'Bearer sometoken'
             }
           )
           .to_return(
             status: 200,
             body: "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"string\"\n}"
           )

    assert_equal "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"string\"\n}", @client.user
  end

  def test_user_failure
    @client = NatureRemo::Client.new('sometoken')
    WebMock.stub_request(:get, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => 'Bearer sometoken'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.user
    end

    assert_equal 'request failed with status code 500, error', error.message
  end

  def test_update_user_nickname_success
    @client = NatureRemo::Client.new('sometoken')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => 'Bearer sometoken'
             },
             body: {
               nickname: 'String'
             }
           )
           .to_return(
             status: 200,
             body: "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"String\"\n}"
           )

    assert_equal "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"String\"\n}", @client.update_user_nickname('String')
  end

  def test_update_user_nickname_failure
    @client = NatureRemo::Client.new('sometoken')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
               'Authorization' => 'Bearer sometoken'
             },
             body: {
               nickname: 'wrong name'
             }
           )
           .to_return(status: 500, body: 'error')

    error = assert_raises NatureRemo::Error do
      @client.update_user_nickname('wrong name')
    end

    assert_equal 'request failed with status code 500, error', error.message
  end
end
