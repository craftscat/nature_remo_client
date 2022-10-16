# frozen_string_literal: true

require_relative 'errors'

module NatureRemo
  # RaiseError is a Faraday response middleware that raises an error if NatureRemo returns non-2xx status codes.
  class RaiseError < Faraday::Middleware
    def on_complete(env) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
      case env[:status]
      when 400
        raise NatureRemo::BadRequest.new(env: env)
      when 401
        raise NatureRemo::Unauthorized.new(env: env)
      when 403
        raise NatureRemo::Forbidden.new(env: env)
      when 404
        raise NatureRemo::NotFound.new(env: env)
      when 405
        raise NatureRemo::MethodNotAllowed.new(env: env)
      when 413
        raise NatureRemo::PayloadTooLarge.new(env: env)
      when 422
        raise NatureRemo::UnprocessableEntity.new(env: env)
      when 429
        raise NatureRemo::TooManyRequests.new(env: env)
      when 400..499
        raise NatureRemo::ClientError.new(env: env)
      when 500
        raise NatureRemo::InternalServerError.new(env: env)
      when 502
        raise NatureRemo::BadGateway.new(env: env)
      when 503
        raise NatureRemo::ServiceUnavailable.new(env: env)
      when 504
        raise NatureRemo::GatewayTimeout.new(env: env)
      when 500..599
        raise NatureRemo::ServerError.new(env: env)
      when nil
        raise NatureRemo::NilStatusError.new(env: env)
      end
    end
  end
end
