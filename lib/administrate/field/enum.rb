require_relative "select"

module Administrate
  module Field
    class Enum < Administrate::Field::Select
      def selectable_options
        resource.class.send(name).options
      end

      def data
        return resource.send("#{name}_text") if resource.respond_to?("#{name}_text")

        resource.send("#{name}").texts
      end
    end
  end
end
