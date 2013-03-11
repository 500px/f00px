# F00px

500px api ruby gem [![Build Status](https://travis-ci.org/500px/f00px.png)](https://travis-ci.org/500px/f00px)

## Installation

Add this line to your application's Gemfile:

    gem 'f00px'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install f00px

## Usage

Add this code to some initializer:

```ruby
F00px.configure do |config|
  config.consumer_key = __consumer_key__
  config.consumer_secret = __consumer_secret__
  config.token = __token__
  config.token_secret = __token_secret__
end
```

Then just use the api:

```ruby
response = F00px.get('users/1')
puts response.body
```

You also can create multiple clients.

With oauth
```ruby
client = F00px::Client.new
client.token = '__client_token__'
client.token_secret = '__client_token_secret__'

response = client.get('users')
puts response.body
```

With xauth
```ruby
client = F00px::Client.new
client.xauth('arthurnn', '**password**')

response = client.get('users')
puts response.body
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request