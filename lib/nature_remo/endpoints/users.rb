# frozen_string_literal: true

module NatureRemo
  module Endpoints
    # Endpoints for user infomation
    module Users
      # Fetch the authenticated user's information.
      # @return [String] User information.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/get_1_users_me
      def user
        get('users/me')
      end

      # Update authenticated user nickname.
      # @params [String] New user nickname.
      # @return [String] Updated user information.
      # @raise [NatureRemo::ServerError] Raise error if resposonse status is NOT success.
      #
      # https://swagger.nature.global/#/default/post_1_users_me
      def update_user_nickname(nickname)
        post('users/me', { nickname: nickname })
      end
    end
  end
end
