# brawlstarsrb

brawlstarsrb is a Ruby implementation of [BrawlAPI](https://docs.brawlapi.cf), the unofficial Brawl Stars API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brawlstars'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brawlstars

## Usage

Example usage:
```ruby
require 'brawlstars'

client = Brawlstars::Client.new(token: "token") # get this from discord.me/BrawlAPI
player = client.getPlayer("LQL")
puts player["name"]
```
More documentation can be found at [rubydoc](https://www.rubydoc.info/github/Karthik99999/brawlstarsrb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
