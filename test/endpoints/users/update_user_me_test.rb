# frozen_string_literal: true

require 'test_helper'

class UpdateUserMeTest < Minitest::Test
  def test_update_user_me_success
    client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'String'
             }
           )
           .to_return(
             status: 200,
             body: "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"String\"\n}"
           )

    assert_equal "{\n\"id\": \"3fa85f64-5717-4562-b3fc-2c963f66afa6\",\n\"nickname\": \"String\"\n}", client.update_user_me(nickname: 'String')
  end

  def test_update_user_me_auth_failure
    client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'wrong name'
             }
           )
           .to_return(status: 401, body: '{"code": 401001, "message": "認証エラー"}')

    error = assert_raises NatureRemo::Unauthorized do
      client.update_user_me(nickname: 'wrong name')
    end

    assert_equal 'request failed with status code 401, {"code": 401001, "message": "認証エラー"}', error.message
  end

  def test_update_user_me_internal_server_error
    client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'wrong name'
             }
           )
           .to_return(status: 500)

    error = assert_raises NatureRemo::InternalServerError do
      client.update_user_me(nickname: 'wrong name')
    end

    assert_equal 'request failed with status code 500, ', error.message
  end

  def test_update_user_me_timeout
    client = NatureRemo::Client.new('token-xxxxx')
    WebMock.stub_request(:post, 'https://api.nature.global/1/users/me')
           .with(
             headers: {
               'Accept' => '*/*',
               'Authorization' => 'Bearer token-xxxxx'
             },
             body: {
               nickname: 'String'
             }
           )
           .to_timeout

    error = assert_raises Faraday::ConnectionFailed do
      client.update_user_me(nickname: 'String')
    end

    assert_equal 'execution expired', error.message
  end
end
