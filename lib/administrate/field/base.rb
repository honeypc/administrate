require_relative "deferred"
require "active_support/core_ext/string/inflections"

module Administrate
  module Field
    class Base
      include ActionView::LookupContext::ViewPaths

      def self.with_options(options = {})
        Deferred.new(self, options)
      end

      def self.html_class
        field_type.dasherize
      end

      def self.associative?
        self < Associative
      end

      def self.eager_load?
        false
      end

      def self.searchable?
        false
      end

      def self.field_type
        to_s.split("::").last.underscore
      end

      def self.permitted_attribute(attr, _options = nil)
        attr
      end

      def initialize(attribute, data, page, options = {})
        @attribute = attribute
        @data = data
        @page = @action_name = page
        @resource = options.delete(:resource)
        @options = options
        @form = options.delete(:form)
        @controller_path = options.delete(:controller_path).to_s
        @controller_name = options.delete(:controller_name).to_s
        @params = options.delete(:params) || {}
      end

      def html_class
        self.class.html_class
      end

      def name
        attribute.to_s
      end

      def resource_class
        options[:resource_class].presence ||
        resource&.class ||
        controller_path.split('/').last.classify.constantize
      end

      def input_name
        "#{resource_class.class_name}[#{name}]"
      end

      def to_partial_path
        "/fields/#{self.class.field_type}/#{page}"
      end

      def to_label_partial_path
        partial_path('label')
      end

      def to_input_partial_path
        partial_path('input')
      end

      def namespace
        controller_path.split('/').first.to_sym
      end

      def controller_path
        @controller_path ||= File.join(namespace, controller_name)
      end

      def action_path
        File.join(controller_path, action_name)
      end

      def view_path
        @view_path ||= File.join(Rails.root, 'app', 'views')
      end

      def partial_path(partial_name)
        [
          "/#{controller_path}/#{action_name}/#{partial_name}",
          "/#{controller_path}/application/#{partial_name}",
          "/#{namespace}/#{partial_name}",
          "/#{namespace}/application/#{partial_name}",
          "/fields/#{self.class.field_type}/#{page}/#{partial_name}",
          "/fields/#{partial_name}"
        ].detect { |p| partial_exist?(p) }.presence || partial_name
      end

      def partial_exist?(partial_path)
        return false if partial_path.blank?

        field_name = partial_path.split(/\//).pop
        folder_path = partial_path.gsub("/#{field_name}", '')
        File.exist? File.join(view_path, folder_path,"_#{field_name.delete_prefix('.html.erb')}.html.erb")
      end

      def required?
        return false unless resource.class.respond_to?(:validators_on)

        resource.class.validators_on(attribute).any? do |v|
          next false unless v.class == ActiveRecord::Validations::PresenceValidator

          options = v.options
          next false if options.include?(:if)
          next false if options.include?(:unless)

          if on_option = options[:on]
            if on_option == :create && !resource.persisted?
              next true
            end

            if on_option == :update && resource.persisted?
              next true
            end

            next false
          end

          true
        end
      end

      attr_reader :attribute, :data, :options, :page, :resource, :form, :controller_path, :controller_name, :action_name, :params
    end
  end
end
