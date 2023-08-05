# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for ECHONET Lite
    module EchonetLite
      # Fetch the list of ECHONET Lite appliances the user has access to.
      #
      # https://swagger.nature.global/#/default/get_1_echonetlite_appliances
      def echonet_lite_appliances
        get('echonetlite/appliances')
      end

      # Notify Remo E / Remo E lite to refresh one or more ECHONET Lite properties.
      # This endpoint is subject to ECHONET Lite specific rate limiting.
      # See the rate limiting section of the documentation for more details.
      # Requires echonetlite.*
      #
      # https://swagger.nature.global/#/default/post_1_echonetlite_appliances__applianceid__refresh
      def refresh_echonet_lite_properties(appliance_id:, epc:)
        post("echonetlite/appliances/#{appliance_id}/refresh", { EPC: epc })
      end

      # Set one ECHONET Lite property. This endpoint is subject to ECHONET Lite specific rate limiting.
      # This endpoint is subject to ECHONET Lite specific rate limiting.
      # See the rate limiting section of the documentation for more details.
      # Requires echonetlite.*
      #
      # https://swagger.nature.global/#/default/post_1_echonetlite_appliances__applianceid__set
      def set_echonet_lite_property(appliance_id:, epc:, val:)
        post("echonetlite/appliances/#{appliance_id}/set", { EPC: epc, Val: val })
      end
    end
  end
end
