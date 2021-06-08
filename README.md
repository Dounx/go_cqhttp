# GoCQHTTP

GoCQHTTP is a client wrapper for [go-cqhttp](https://github.com/Mrs4s/go-cqhttp)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'go_cqhttp'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install go_cqhttp

## Usage

```rb
bot = GoCQHTTP::Bot.new(host: "https://yourserver", access_token: "your token")

# /get_login_info
bot.get_login_info

# /get_group_info
bot.get_group_info(group_id: "your group id")

# /send_private_msg
face = GoCQHTTP::CQ::Face.new(id: 1)
bot.send_private_msg(user_id: "your qq number", message: "OK #{face}")
```

Notice: 

* "admin/*" is map to `bot.admin_*`
* ".*" is map to `hidden_*`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, config TEST_* environment (See test_helper.rb) and run `rake test` to run the tests.

You can also run `rake console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dounx/go_cqhttp.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
