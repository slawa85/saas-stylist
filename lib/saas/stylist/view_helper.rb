module Saas
  module Stylist
    module ViewHelpers
      def app_title
        Saas::Stylist.configuration.app_title
      end
    end
  end
end
