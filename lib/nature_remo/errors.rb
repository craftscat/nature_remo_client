# frozen_string_literal: true

module NatureRemo
  # Error class for Nature Remo API
  class Error < StandardError
    attr_reader :env, :url, :status, :headers, :body, :error_code

    # @param env Faraday::Env
    def initialize(env:)
      @env = env
      @url = env.url
      @status = env.status
      @headers = env.response_headers
      @body = env.body

      msg = "request failed with status code #{@status}"
      msg += ", #{@body}" if @body

      super(msg)
    end
  end

  # Raised on errors in the 400s status
  class ClientError < Error; end
  # Raised when Nature Remo API returns a 400 HTTP status code
  class BadRequest < ClientError; end
  # Raised when Nature Remo API returns a 401 HTTP status code
  class Unauthorized < ClientError; end
  # Raised when Nature Remo API returns a 403 HTTP status code
  class Forbidden < ClientError; end
  # Raised when Nature Remo API returns a 404 HTTP status code
  class NotFound < ClientError; end
  # Raised when Nature Remo API returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end
  # Raised when Nature Remo API returns a 413 HTTP status code
  class PayloadTooLarge < ClientError; end
  # Raised when Nature Remo API returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end
  # Raised when Nature Remo API returns a 429 HTTP status code
  class TooManyRequests < ClientError; end

  # Raised on errors iin the 500s status
  class ServerError < Error; end
  # Raised when Nature Remo API returns a 500 HTTP status code
  class InternalServerError < ServerError; end
  # Raised when Nature Remo API returns a 502 HTTP status code
  class BadGateway < ServerError; end
  # Raised when Nature Remo API returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end
  # Raised when Nature Remo API returns a 504 HTTP status code
  class GatewayTimeout < ServerError; end

  # Raised when Nature Remo API returns without HTTP status code
  class NilStatusError < ServerError; end
end
