# Query Params

Format URL parameters like a query.
It allows you to send operators and the same parameter twice on the same request. 

For example: 
```
http://domain.com/search?filters=age::ge(18)|age::le(25)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'query-params'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install query-params

## Usage

```ruby
# Complete URI
URI::QueryParams.build_uri(base_uri: "http://domain.com/search", q: "Mark", filters: ["age <= 18", "type = 1"])
# => "http://domain.com/search?q=Mark&filters=age::le(18)|type::eq(1)"

# Only query params
URI::QueryParams.filters(filters: ["age <= 18", "type = 1"])
# => "age::le(18)|type::eq(1)"
```

## Contributing

1. Fork it ( https://github.com/willmiranda/query-params/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
