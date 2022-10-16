# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for user infomation
    module Appliances
      # Fetch the list of appliances.
      # @return [String] The list of appliances.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/get_1_appliances
      def appliances
        get('appliances')
      end

      # Create a new appliance.
      # @param [String] device_id Device ID
      # @param [String] nickname Appliance name.
      # @param [String] image Basename of the image file included in the app. Ex: "ico_ac_1"
      # @param [String] model ApplianceModel ID if the appliance we're trying to create is included in IRDB.
      # @param [String] model_type Available values : AC, TV, LIGHT
      # @return [String] Created an appliance.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances
      def create_appliance(device_id:, nickname:, image:, model: nil, model_type: nil)
        params = {
          device: device_id,
          nickname: nickname,
          image: image
        }
        params[:model] = model if model.present?
        params[:model_type] = model_type if model_type.present?

        post('appliances', params)
      end

      # Reorder appliances.
      # @param [String] appliance_ids List of all appliances' IDs comma separated
      # @return [String] Reordered appliances
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliance_orders
      def update_appliance_orders(appliance_ids:)
        post('appliance_orders', { appliances: appliance_ids })
      end

      # Update appliance.
      # @param [String] appliance_id Appliance ID.
      # @param [String] nickname Appliance name
      # @param [String] image Basename of the image file included in the app. Ex: "ico_ac_1"
      # @return [String] Updated air conditioner settings.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance_
      def update_appliance(appliance_id:, nickname:, image:)
        post("appliances/#{appliance_id}", { nickname: nickname, image: image })
      end

      # Delete appliance.
      # @param [String] appliance_id Appliance ID.
      # @return [String] Deleted an appliance.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__delete
      def delete_appliance(appliance_id:)
        post("appliances/#{appliance_id}/delete")
      end

      # Update air conditioner settings.
      # @param [String] appliance_id Appliance ID.
      # @param [String] button Button
      # @param [String] temperature Temperature
      # @param [String] operation_mode AC operation mode
      # @param [String] air_volume AC air volume
      # @param [String] air_direction AC air direction
      # @return [String] Updated air conditioner settings
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__aircon_settings
      def update_aircon_settings(appliance_id:, button: nil, temperature: nil, operation_mode: nil, air_volume: nil, air_direction: nil)
        params = {}
        params[:button] = button if button.present?
        params[:temperature] = temperature if temperature.present?
        params[:operation_mode] = operation_mode if operation_mode.present?
        params[:air_volume] = air_volume if air_volume.present?
        params[:air_direction] = air_direction if air_direction.present?

        post("appliances/#{appliance_id}/aircon_settings", params)
      end

      # Send tv infrared signal.
      # @param [String] appliance_id Appliance ID.
      # @param [String] button Button name
      # @return [String] Updated tv state
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__tv
      def update_tv_state(appliance_id:, button:)
        post("appliances/#{appliance_id}/tv", { button: button })
      end

      # Send light infrared signal.
      # @param [String] appliance_id Appliance ID.
      # @param [String] button Button name
      # @return [String] Updated light state
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__light
      def update_light_state(appliance_id:, button:)
        post("appliances/#{appliance_id}/light", { button: button })
      end
    end
  end
end
