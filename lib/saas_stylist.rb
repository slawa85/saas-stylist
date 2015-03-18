require 'saas/stylist'

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
    # application layout
    attr_accessor :styling

    # application logger
    attr_accessor :logger

    # application title
    attr_accessor :app_title

    def initialize
      @styling = @logger = @app_title = {}
    end
  end
end
