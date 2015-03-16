require 'saas/stylist/version'

module Saas
  module Stylist
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        config.assets.precompile += ['awesome_font.css',
                                     'common.js',
                                     'custom.css.erb']
      end
    end
  end
end
