# nature_remo_client（Nature Remo API Client for Ruby）

[![Gem Version](https://badge.fury.io/rb/nature_remo_client.svg)](https://rubygems.org/gems/nature_remo_client)
[![GitHub Actions CI](https://github.com/craftscat/nature_remo_client/workflows/CI/badge.svg)](https://github.com/craftscat/nature_remo_client/actions?query=workflow%3ACI)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/nature_remo_client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add nature_remo_client

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install nature_remo_client

## Usage
### Users

```ruby
require 'nature_remo_client'

client = NatureRemo::Client.new(<token>)

# Get user info
client.user_me

# Update user nickname
client.update_user_me(nickname: <nickname>)
```

### Devices
```ruby
require 'nature_remo_client'

client = NatureRemo::Client.new(<token>)

# Get Remos
client.devices

# Update Remo name
client.update_device(device_id: <device_id>, name: <name>)

# Delete Remo
client.delete_device(device_id: <device_id>)

# Update temperature offset
client.update_device_temperature_offset(device_id: <divice_id>, offset: <offset>)

# Update humidity offset
client.update_device_humidity_offset(device_id: <divice_id>, offset: <offset>)
```

### Appliances
```ruby
require 'nature_remo_client'

client = NatureRemo::Client.new(<token>)

# get appliances
client.appliances

# Create a new appliance
client.create_appliance(device_id: <divice_id>, nickname: <nickname>, image: <image>, model: <model>, model_type: <model_type>)

# Reorder appliances
client.update_appliance_orders(appliance_ids: <appliance_ids>)

# Update appliance
client.update_appliance(appliance_id: <appliance_id>, nickname: <nickname>, image: <image>)

# Delete appliance
client.delete_appliance(appliance_id: <appliance_id>)

# Update air conditioner settings
client.update_aircon_settings(appliance_id: <appliance_id>, temperature: <temperature>)

# Update TV infrared signal
client.update_tv_state(appliance_id: <appliance_id>, button: <button>)

# Send light infrared signal
client.update_light_state(appliance_id: <appliance_id>, button: <button>)
```

### Signals
```ruby
require 'nature_remo_client'

client = NatureRemo::Client.new(<token>)

# get signals
client.signals(appliance_id: <appliance_id>)

# Create a signal under this appliance
client.create_signal(appliance_id: <appliance_id>, name: <name>, image: <image>, message: <message>)

# Reorder signals under this appliance
client.update_signal_orders(appliance_ids: <appliance_ids>, signal_ids: <signal_ids>)

# Update infrared signal
client.update_signal(appliance_id: <appliance_id>, name: <name>, image: <image>)

# Delete signal
client.delete_signal(signal_id: <signal_id>)

# Send infrared signal
client.send_signal(signal_id: <signal_id>)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/craft-cat/nature_remo_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/craft-cat/nature_remo_client/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NatureRemo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/craft-cat/nature_remo_client/blob/main/CODE_OF_CONDUCT.md).
