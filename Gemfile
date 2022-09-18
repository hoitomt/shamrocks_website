source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.6.4'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4.2'
gem 'jbuilder', '~> 2.11'
gem 'solargraph', '~> 0.43.0'
gem 'bootsnap', '>= 1.4.8', require: false
gem 'simple_form', '~> 5.1.0'
gem 'stripe', '~> 5.38.0'
gem 'thor', '~> 1.2.0'
gem 'net-smtp', '~> 0.3.1'
gem 'matrix', '~> 0.4.2'

# this is to remove a warning `DidYouMean::SPELL_CHECKERS` on rails start
# gem 'did_you_mean', '~> 1.5.0'

group :development, :test do
  gem 'byebug', '~> 11.1'
  gem 'rspec-rails', '~> 5.0.2'
  gem 'rails-controller-testing', '~> 1.0.5'
end

group :development do
  gem 'web-console', '>= 4.0.4'
  gem 'listen', '~> 3.7'
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0'
end

group :test do
  gem 'capybara', '>= 3.33'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'webdrivers', '~> 4.6.1'
end
