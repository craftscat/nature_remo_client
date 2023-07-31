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
    end
  end
end
