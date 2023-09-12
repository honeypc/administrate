require_relative "base"

module Administrate
  module Page
    class Show < Page::Base
      def initialize(dashboard, resource, options = {})
        super(dashboard, options)
        @resource = resource
        @options = options
      end

      attr_reader :resource, :options

      def page_title
        dashboard.display_resource(resource)
      end

      def attributes
        dashboard.show_page_attributes.map do |attr_name|
          attribute_field(dashboard, resource, attr_name, :show, options.merge(resource: resource))
        end
      end
    end
  end
end
