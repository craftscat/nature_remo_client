# frozen_string_literal: true

require_relative 'endpoints'

module NatureRemo
  # Client to send requests to Nature Remo cloud API
  class Client
    include NatureRemo::Endpoints

    BASE_URL = 'https://api.nature.global/'
    API_VERSION = '1'

    def initialize(access_token)
      raise ArgumentError, 'argument access_token must not be nil' if access_token.nil?

      @client = Faraday.new(url: "#{BASE_URL}#{API_VERSION}/") do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        conn.adapter Faraday.default_adapter
        conn.use RaiseError
      end
      @client.headers['Authorization'] = "Bearer #{access_token}"
    end

    private

    def get(path)
      response = @client.get(path)

      raise NatureRemo::Error, "request failed with status code #{response.status}, #{response.body}" unless response.success?

      response.body
    end

    def post(path, params = nil)
      response = @client.post(path) do |req|
        req.body = params
      end

      raise NatureRemo::Error, "request failed with status code #{response.status}, #{response.body}" unless response.success?

      response.body
    end
  end
end
