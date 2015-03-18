# Saas::Stylist

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'saas-stylist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install saas-stylist

## Usage

This gem need few settings to work properly, in you application settings.yml or
settings.local.yml add following configurations using yaml format:

    styling:
      template_layout:
        regular_page: https://openproject.yopeso.com/concierge
        minimum_length: 3000
        read_options:
          read_timeout: 8 # seconds
          ssl_verify_mode: 0
      regular_place_holder: <div class="vertical-center-holder" id="op-sass-content"></div>

Once you added the configuration in settings file you should create an initializer in config/initializers
directory, where you will specify which config should take for styling, logger and application title
like in exemple below:

    Saas::Stylist.configure do |config|
      config.styling = Settings.styling
      config.logger = Rails.logger || Logger.new(STDOUT)
      config.app_title = 'Your application title'
    end


  

## Contributing

1. Fork it ( https://github.com/[my-github-username]/saas-stylist/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
