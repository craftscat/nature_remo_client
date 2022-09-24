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

      # Create a signal under this appliance.
      # @param [String] nickname Appliance name.
      # @param [String] model ApplianceModel ID if the appliance we're trying to create is included in IRDB.
      # @param [String] model_type Available values : AC, TV, LIGHT
      # @param [String] device_id Device ID
      # @param [String] image Basename of the image file included in the app. Ex: "ico_ac_1"
      # @return [String] Created an appliance.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances
      def create_appliance(nickname, model, model_type, device_id, image)
        params = {
          nickname: nickname,
          model: model,
          model_type: model_type,
          device: device_id,
          image: image
        }

        post('appliances', params)
      end

      # Reorder appliances.
      # @param [String] orderd_appliance_ids List of all appliances' IDs comma separated
      # @return [String] Reordered appliances
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliance_orders
      def update_appliance_orders(orderd_appliance_ids)
        post('appliance_orders', { appliance: orderd_appliance_ids })
      end

      # Delete appliance.
      # @param [String] appliance_id Appliance ID.
      # @return [String] Deleted an appliance.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__delete
      def delete_appliance(appliance_id)
        post("appliances/#{appliance_id}/delete")
      end

      # Update appliance.
      # @param [String] appliance_id Appliance ID.
      # @param [String] image Basename of the image file included in the app. Ex: "ico_ac_1"
      # @param [String] nickname Appliance name
      # @return [String] Updated air conditioner settings.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance_
      def update_appliance(appliance_id, image, nickname)
        post("appliances/#{appliance_id}", { image: image, nickname: nickname })
      end

      # Update air conditioner settings.
      # @param [String] appliance_id Appliance ID.
      # @param [String] temperature Temperature
      # @param [String] operation_mode AC operation mode
      # @param [String] air_volume AC air volume
      # @param [String] air_direction AC air direction
      # @param [String] button Button
      # @return [String] Updated air conditioner settings
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__aircon_settings
      def update_aircon_settings(appliance_id, temperature, operation_mode, air_volume, air_direction, button)
        params = {
          temperature: temperature,
          operation_mode: operation_mode,
          air_volume: air_volume,
          air_direction: air_direction,
          button: button
        }

        post("appliances/#{appliance_id}/aircon_settings", params)
      end

      # Send tv infrared signal.
      # @param [String] appliance_id Appliance ID.
      # @param [String] button Button name
      # @return [String] Updated tv state
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__tv
      def update_tv_state(appliance_id, button)
        post("appliances/#{appliance_id}/tv", { button: button })
      end

      # Send light infrared signal.
      # @param [String] appliance_id Appliance ID.
      # @param [String] button Button name
      # @return [String] Updated light state
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_appliances__appliance__light
      def update_light_state(appliance_id, button)
        post("appliances/#{appliance_id}/light", { button: button })
      end
    end
  end
end
