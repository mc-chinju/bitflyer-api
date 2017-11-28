# BitflyerApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bitflyer_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitflyer_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitflyer_api

## Usage

```ruby
require "bitflyer_api"

BitflyerApi.config do |config|
  config.key    = YOUR_API_KEY
  config.secret = YOUR_API_SECRET
end

client = BitflyerApi.client
client.my_addresses
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mc-chinju/bitflyer_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
