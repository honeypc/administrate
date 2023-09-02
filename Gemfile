source 'https://rubygems.org'
ruby "3.2.2" unless ENV["CI"]

gemspec

# %w[
#   image
#   nested_has_many
#   active_storage
#   belongs_to_search
#   jsonb
#   lat_lng
#   money
#   trix
#   acts_as_taggable
#   collection_select
#   select_essential
#   lazy_belongs_to
#   scoped_belongs_to
#   lazy_has_many
#   scoped_has_many
#   color
#   globalize
#   enumerate
#   paper_trail
#   array
#   telephone
#   has_many_search
# ].each do |field|
#   gem "administrate-field-#{field}"
# end

gem "administrate-field-image"
gem "faker"
gem "front_matter_parser"
gem "globalid"
gem "kaminari-i18n"
gem "pg"
gem "pundit"
gem "redcarpet"
gem "sentry-raven"
gem "unicorn"
gem 'require_all'
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tailwindcss-rails'

group :development, :test do
  gem "appraisal"
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "i18n-tasks", "1.0.12"
  gem "pry"
  gem "yard"
end

group :test do
  gem "ammeter"
  gem "capybara"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "selenium-webdriver", "= 4.9.0"
  gem "shoulda-matchers"
  gem "timecop"
  gem "webdrivers"
  gem "webmock"
  gem "webrick"
  gem "xpath", "3.2.0"
end

group :staging, :production do
  gem "rack-timeout"
  gem "uglifier"
end
