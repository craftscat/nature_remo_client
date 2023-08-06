# frozen_string_literal: true

require_relative 'endpoints/appliances'
require_relative 'endpoints/devices'
require_relative 'endpoints/echonet_lite'
require_relative 'endpoints/signals'
require_relative 'endpoints/users'

module NatureRemo
  # Endpoints of Nature Remo Cloud API
  module Endpoints
    include Appliances
    include Devices
    include EchonetLite
    include Signals
    include Users
  end
end
