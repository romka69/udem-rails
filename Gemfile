source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'haml-rails', '~> 2.0'
gem 'bootstrap', '~> 4.5.2'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 5.13.0'
gem 'simple_form'
gem 'faker'
gem 'devise'
gem 'friendly_id', '~> 5.4.0'
gem 'ransack'
gem 'public_activity'
gem 'rolify'
gem 'pundit'
gem 'exception_notification'
gem 'pagy', '~> 3.5'
gem 'chartkick'
gem 'groupdate'
gem 'ranked-model'
gem 'aws-sdk-s3', require: false
gem 'active_storage_validations'
gem 'mini_magick', '>= 4.9.5'
gem 'image_processing'
gem 'recaptcha'
gem 'sitemap_generator'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'wicked_pdf'
gem "cocoon"
gem 'stripe'

group :production do
  gem 'wkhtmltopdf-heroku'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'letter_opener'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
  gem 'ruby-graphviz'
  gem 'wkhtmltopdf-binary'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
