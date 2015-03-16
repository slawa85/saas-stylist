module Saas
  module Stylist
    class Engine < ::Rails::Engine
      engine_name :saas_stylist
      
      config.before_configuration do
        config.assets.precompile += ['awesome_font.css',
                                     'common.js',
                                     'custom.css.erb']
      end
    end
  end
end
