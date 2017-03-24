source "https://rubygems.org"
source 'https://rails-assets.org' do
  gem "rails-assets-underscore"
end

ruby "2.3.1"

gem 'rails', '~> 5.0.0.beta1'
gem "pg"
gem "figaro"
gem "simple_form"
gem "mail_form"
gem "country_select"
gem "high_voltage"
gem "faker"
gem "devise"
gem "pundit"
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', git: 'https://github.com/zquestz/omniauth-google-oauth2.git'
gem 'mangopay', '~> 3.0', '>= 3.0.23'
gem 'intercom', "~> 3.4.0"
gem "intercom-rails"
gem 'sidekiq'
gem 'sinatra', github: 'sinatra/sinatra', branch: 'master'  # Dependency of sidekiq
gem 'sidekiq-failures'
gem 'possibly'
gem 'turnout'
gem 'scout_apm'

gem "aws-sdk", "< 2.0"
gem 'carrierwave'
gem "cloudinary"
gem 'remotipart', '~> 1.2'
gem "gibbon"
gem 'postmark-rails', '~> 0.14.0'
gem 'activeadmin', github: 'activeadmin'

gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "uglifier"
gem "bootstrap-sass"
gem "font-awesome-sass"
gem "autoprefixer-rails"
gem "geocoder"
# gem 'forest_liana'
gem "underscore-rails"
gem "rails-erd"
gem 'mobvious'
gem 'mobvious-rails'
gem 'slack-notifier'
gem 'amplitude-api'
gem 'listjs-rails'
gem 'one_signal'

gem 'bootstrap-datepicker-rails'
gem "time_splitter"

gem "rails-i18n"
gem "devise-i18n"
gem "devise-i18n-views"

group :development, :staging do
  gem "spring"
  gem "annotate"
  gem "binding_of_caller"
  gem "better_errors"
  gem "quiet_assets"
  gem "pry-byebug"
  gem "pry-rails"
  gem "letter_opener"
  gem 'meta_request'
  gem 'bullet'
end

group :production do
  gem "rails_12factor"
  gem "puma"
  gem "rack-timeout"
end
