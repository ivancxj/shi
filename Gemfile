source 'http://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'faraday'
#gem 'crack'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'thin'
# gem 'activeuuid'
gem 'redis', '~> 3.0.1'
gem 'redis-store', :git=>'git://github.com/jodosha/redis-store.git'
# Redis 命名空间
gem 'redis-namespace','~> 1.2.1'
# 将一些数据存放入 Redis
gem 'redis-objects', '0.5.2'
group :development, :test do
  gem 'quiet_assets'
end

group :production do
  #gem 'dalli', '1.1.1'
  gem 'unicorn'
end
# YAML 配置信息
gem "settingslogic", '~> 2.0.9'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

