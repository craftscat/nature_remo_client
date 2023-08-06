# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for ECHONET Lite
    module EchonetLite
      # Fetch the list of ECHONET Lite appliances the user has access to.
      # @return [String] The list of ECHONET Lite appliances.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/get_1_echonetlite_appliances
      def echonet_lite_appliances
        get('echonetlite/appliances')
      end

      # Notify Remo E / Remo E lite to refresh one or more ECHONET Lite properties.
      # This endpoint is subject to ECHONET Lite specific rate limiting.
      # See the rate limiting section of the documentation for more details. Requires echonetlite.*
      # @params appliance_id [String] The ECHONET Lite appliance id.
      # @params epc [String] Comma separated EPCs in hex.
      # @return [String] empty object.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_echonetlite_appliances__applianceid__refresh
      def refresh_echonet_lite_properties(appliance_id:, epc:)
        post("echonetlite/appliances/#{appliance_id}/refresh", { EPC: epc })
      end

      # Set one ECHONET Lite property. This endpoint is subject to ECHONET Lite specific rate limiting.
      # This endpoint is subject to ECHONET Lite specific rate limiting.
      # See the rate limiting section of the documentation for more details. Requires echonetlite.*
      # @params appliance_id [String] The ECHONET Lite appliance id.
      # @params epc [String] EPC in hex string.
      # @params val [String] Value in hex string. eg: 000000FF
      # @return [String] empty object.
      # raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_echonetlite_appliances__applianceid__set
      def set_echonet_lite_property(appliance_id:, epc:, val:)
        post("echonetlite/appliances/#{appliance_id}/set", { EPC: epc, Val: val })
      end
    end
  end
end
