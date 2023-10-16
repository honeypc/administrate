require_relative "base"

module Administrate
  module Field
    class Ancestry < Field::Base
      def self.searchable?
        true
      end

      def selectable_options
        if resource.class.respond_to?(:roots)
          resource.class.roots
        else
          resource.class.all
        end.map { |r| [r.to_s, r.id] }
      end

      def include_blank_option
        options.fetch(:include_blank, false)
      end
    end
  end
end
