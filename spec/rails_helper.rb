# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'rspec/rails'
require 'spec_helper'


# webmock
require 'webmock/rspec'


# allow code climate to send whenever it wants to :)
WebMock.disable_net_connect!(allow: 'codeclimate.com')

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
# Dir[Rails.root.join("spec/support/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.infer_base_class_for_anonymous_controllers = false
end
