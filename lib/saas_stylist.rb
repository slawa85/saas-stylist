require 'saas/stylist' if defined?(Rails)

module Saas::Stylist
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.include_stylized_controller
    require 'stylized_controller'
  end

  class Configuration
    # Store configuration needed for entire
    # application layout
    attr_accessor :application_styling

    # Store configuration required for error page layout
    attr_accessor :error_styling

    def initialize
      @error_styling = @application_styling = {}
    end
  end
end
