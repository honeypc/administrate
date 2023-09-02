require_relative "select"

module Administrate
  module Field
    class Enum < Administrate::Field::Select
      def selectable_options
        resource.class.send(name).options
      end
    end
  end
end
