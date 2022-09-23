# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for Nature Remo devices
    module Devices
      # Fetch the list of Remo devices the user has access to.
      # @return [String] The list of Remo devices.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/get_1_devices
      def devices
        get('devices')
      end

      # Update Remo Name.
      # @param [String] device_id Remo id.
      # @param [String] name New Remo name.
      # @return [String]
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_devices__device_
      def update_device(device_id, name)
        post("devices/#{device_id}", { name: name })
      end

      # Delete Remo.
      # @param [String] device_id Remo id.
      # @return [String] Deleted Remo.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_devices__device__delete
      def delete_device(device_id)
        post("devices/#{device_id}/delete")
      end

      # Update temperature offset.
      # @param [String] device_id Remo id.
      # @param [String] offset Temperature offset value added to the measured temperature.
      # @return [String] Updated
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_devices__device__temperature_offset
      def update_device_temperature_offset(device_id, offset)
        post("devices/#{device_id}/temperature_offset", { offset: offset })
      end

      # Update humidity offset.
      # @param [String] device_id Remo id.
      # @param [String] offset Humidity offset value added to the measured humidity.
      # @return [String] Updated
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_devices__device__humidity_offset
      def update_device_humidity_offset(device_id, offset)
        post("devices/#{device_id}/humidity_offset", { offset: offset })
      end
    end
  end
end
