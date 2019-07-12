# UspsWebTools

Ruby API for accessing the USPS WebTools API

USPS Web Tools API: https://www.usps.com/business/web-tools-apis/#api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'usps_web_tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install usps_web_tools

## Usage

Before you start, setup your environment variables
<li>USPS_USER</li>
<li>USPS_PW</li>

One, instantiate your parameter objects
```ruby
parameter1 = USPSWebTools::Parameter::ZipCode.new(id: 1, zip5: '94108')
parameter2 = USPSWebTools::Parameter::ZipCode.new(id: 2, zip5: '94014')
parameters = [parameter1, parameter2]
```

Two, get the request URL
```ruby
requests = USPSWebTools::Requests.new(api: 'CityStateLookupRequest', user_id: ENV['USPS_USER'], password: ENV['USPS_PW'], parameters: parameters)
url = requests.to_url
```

Three, use your favorite HTTP client to submit your request. The example here uses <i>faraday</i>
```ruby
submission = Faraday.new(url: url)
faraday_response = submission.get
response_in_xml = faraday_response.body
```

Last, read the responses
```ruby
responses = USPSWebTools::Responses.new(xml: response_in_xml)
responses[0].city # SAN FRANCISCO
responses[1].city # DALY CITY
```

See examples under ./spec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lkfken/usps_web_tools.
