require 'saas/stylist/view_helper'
module Saas
  module Stylist
    class Engine < ::Rails::Engine
      engine_name :saas_stylist

      initializer 'saas_stylist.view_helpers' do
        ActionView::Base.send :include, ViewHelpers
      end

      config.before_configuration do
        config.assets.precompile += ['awesome_font.css',
                                     'common.js',
                                     'custom.css.erb']
      end
    end
  end
end
