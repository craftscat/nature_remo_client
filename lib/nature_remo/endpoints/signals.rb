# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for user infomation
    module Signals
      # Fetch signals registered under this appliance.
      # @param [String] appliance_id Appliance ID.
      # @return [String] List of signals
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/get_1_appliances__appliance__signals
      def signals(appliance_id:)
        get("appliances/#{appliance_id}/signals")
      end

      # Create a signal under this appliance.
      # @param [String] appliance_id Appliance ID.
      # @param [String] message JSON serialized object describing infrared signals. Includes "data", "freq" and "format" keys.
      # @param [String] image Basename of the image file included in the app. Ex: "ico_io"
      # @param [String] name Signal name
      # @return [String] Created signal
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__signals
      def create_signal(appliance_id:, name:, image:, message:)
        params = {
          name: name,
          image: image,
          message: message
        }

        post("appliances/#{appliance_id}/signals", params)
      end

      # Reorder signals under this appliance.
      # @param [String] appliance_id Appliance ID.
      # @signal_ids [String] List of all signals' IDs comma separated
      # @return [String] Reordered signals
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__signal_orders
      def update_signal_orders(appliance_id:, signal_ids:)
        post("appliances/#{appliance_id}/signal_orders", { signals: signal_ids })
      end

      # Update infrared signal.
      # @param [String] signal_id Signal ID.
      # @param [String] image Basename of the image file included in the app. Ex: "ico_io"
      # @param [String] name Signal name
      # @return [String] Updated infrared signal
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_signals__signal_
      def update_signal(signal_id:, name:, image:)
        post("signals/#{signal_id}", { name: name, image: image })
      end

      # Delete an infrared signal.
      # @param [String] signal_id Signal ID.
      # @return [String] Deleted a signal
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_signals__signal__delete
      def delete_signal(signal_id:)
        post("signals/#{signal_id}/delete")
      end

      # Send infrared signal.
      # @param [String] signal_id Signal ID.
      # @return [String] Successfully sent infrared signal
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_signals__signal__send
      def send_signal(signal_id:)
        post("signals/#{signal_id}/send")
      end
    end
  end
end
