require "administrate/engine"
require "administrate/version"

module Administrate
  def self.warn_of_missing_resource_class
    ActiveSupport::Deprecation.warn(
      "Calling Field::Base.permitted_attribute without the option " +
      ":resource_class is deprecated. If you are seeing this " +
      "message, you are probably using a custom field type that" +
      "does this. Please make sure to update it to a version that " +
      "does not use a deprecated API",
    )
  end

  def self.warn_of_deprecated_option(name)
    ActiveSupport::Deprecation.warn(
      "The option :#{name} is deprecated. " +
      "Administrate should detect it automatically. " +
      "Please file an issue at " +
      "https://github.com/thoughtbot/administrate/issues " +
      "if you think otherwise.",
    )
  end

  def self.warn_of_deprecated_method(klass, method)
    ActiveSupport::Deprecation.warn(
      "The method #{klass}##{method} is deprecated. " +
      "If you are seeing this message you are probably " +
      "using a dashboard that depends explicitly on it. " +
      "Please make sure you update it to a version that " +
      "does not use a deprecated API",
    )
  end

  def self.warn_of_deprecated_authorization_method(method)
    ActiveSupport::Deprecation.warn(
      "The method `#{method}` is deprecated. " +
      "Please use `accessible_action?` instead, " +
      "or see the documentation for other options.",
    )
  end

  class << self
    attr_accessor :configuration, :tailwind_content
  end

  class Configuration
    attr_reader :importmap

    def initialize
      @importmap = Importmap::Map.new
      @importmap.draw(Engine.root.join("config/importmap.rb"))
      @tailwind_content = [
        "#{Administrate::Engine.root}/app/views/**/*",
        "#{Administrate::Engine.root}/app/helpers/**/*",
        "#{Administrate::Engine.root}/app/controllers/**/*",
        "#{Administrate::Engine.root}/app/javascript/**/*.js"
      ]
    end
  end

  def self.init_config
    self.configuration ||= Configuration.new
  end

  def self.configure
    init_config
    yield(configuration)
  end
end

Administrate.init_config
