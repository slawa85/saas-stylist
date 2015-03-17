require 'saas/stylist/engine'
require 'saas/stylist/version'

module Saas
  module Stylist
    module FancyRenderer

      protected

      def render(options = nil, extra_options = {}, &block)
        @styling_config = Saas::Stylist.configuration.styling
        return super unless stylize?(options)
        template = download_template
        rendered = render_to_string(options, extra_options, &block)
        processed_template = process_template(template, rendered)
        super inline: processed_template
      rescue TemplateException, OpenURI::HTTPError, Timeout::Error => e
        logger.error "Rendering into wordpress template failed with the error: #{e.message}"
        (options || extra_options).merge!(layout: 'stylist/application')
        super
      rescue => e # handle all other possible exceptions
        logger.error "Unexpected exception during the rendering into wordpress template: #{e.message}"
        (options || extra_options).merge!(layout: 'stylist/application')
        super
      end

      private

      def stylize?(options)
        !(options && options.is_a?(Hash) && (
            options[:status] && options[:status] != 200 ||
            options[:json] ||
            options[:text]
            )
        )
      end

      class TemplateException < Exception
      end

      def download_template
        cache('openproject_template') do
          logger.info 'INFO -- : downloading the template from wordpress version'

          uri = @styling_config[:template_layout][:regular_page]
          read_options = @styling_config[:template_layout][:read_options]
          open(uri, read_options.to_h).read
        end
      end

      def process_template(template, rendered)
        fail TemplateException, 'The template is too short.' if
            template.length <@styling_config[:template_layout][:minimum_length]
        number_of_replaced_place_holders = 0
        result = template.gsub(@styling_config[:regular_place_holder]) do
          number_of_replaced_place_holders += 1
          rendered
        end
        result = include_assets(result)

        return result if number_of_replaced_place_holders == 1

        fail TemplateException,
             "The place holder has been found #{number_of_replaced_place_holders} times."
      end

      def include_assets(template)
        font_css_link = ActionController::Base.helpers.asset_path('awesome_font.css')
        css = "<link href='#{font_css_link}' rel='stylesheet' type='text/css'/>\n"

        common_js_link = ActionController::Base.helpers.asset_path('common.js')
        js = "<script src='#{common_js_link}' type='text/javascript'></script>\n"

        template.gsub('</head>', "#{css}#{js}</head>")
      end
    end
  end
end
