# SimpleMDM Ruby bindings

This is a lightweight SDK that acts as a launching point for integrating ruby-based applications with [SimpleMDM](http://www.simplemdm.com/). The native API is a RESTful JSON implementation. These bindings wrap the API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplemdm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplemdm

## Usage

Full documentation is available here: [http://www.simplemdm.com/docs/api/](http://www.simplemdm.com/docs/api/)

    require 'simplemdm'

    # provide your api key for access

    SimpleMDM::api_key = 'j75m8YtUGEaEO5TysjzAXihE07nKoUm9'

    # lock a device

    device = SimpleMDM::Device.find(23)
    device.lock message:      "This device has been locked. Please call the number provided.",
    		    phone_number: "5035555847"


    # upload an enterprise app and deploy it to a group of devices

    app_data = IO.binread('surfreport2.2.ipa')
    app      = SimpleMDM::App.new name:   "Surf Report",
                                  binary: data
    app.save

    app_group = SimpleMDM::AppGroup.find(37)
    app_group.add_app(app)
    app_group.push_apps


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/SimpleMDM/simplemdm-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
