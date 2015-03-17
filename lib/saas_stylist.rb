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

  class Configuration
    # Store configuration needed for
    # application layout
    attr_accessor :styling

    def initialize
      @styling = {}
    end
  end
end
