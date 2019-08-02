source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'


gem 'rails', '~> 5.2.3'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'

# Simple HTTP and REST client for Ruby, inspired by microframework syntax for specifying actions
gem 'rest-client'
# ActiveModel::Serializer implementation and Rails hooks #https://github.com/rails-api/active_model_serializers/tree/0-10-stable
gem 'active_model_serializers', '~> 0.10.0'
# A plugin for versioning Rails based RESTful APIs. 
gem 'versionist'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  #Annotate Rails classes with schema and routes info
  gem 'annotate'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
