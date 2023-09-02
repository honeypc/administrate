# desc "Explaining what the task does"
namespace :administrate do
  # Task goes here
  task :tailwind_engine_watch do
    require "tailwindcss-rails"
    # NOTE: tailwindcss-rails is an engine
    system "#{Tailwindcss::Engine.root.join("exe/tailwindcss")} \
           -i #{MyEngine::Engine.root.join("app/assets/stylesheets/application.tailwind.css")} \
           -o #{MyEngine::Engine.root.join("app/assets/builds/administrate.css")} \
           -c #{MyEngine::Engine.root.join("config/tailwind.config.js")} \
           --minify -w"
  end
end
