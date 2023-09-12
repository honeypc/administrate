require_relative "base"

module Administrate
  module Page
    class Form < Page::Base
      def initialize(dashboard, resource, options = {})
        super(dashboard, options)
        @resource = resource
        @options = options
      end

      attr_reader :resource, :options

      def attributes(action = nil)
        dashboard.form_attributes(action).map do |attribute|
          attribute_field(dashboard, resource, attribute, :form, options.merge(resource: resource))
        end
      end

      def page_title
        dashboard.display_resource(resource)
      end

      private

      attr_reader :dashboard, :options
    end
  end
end
