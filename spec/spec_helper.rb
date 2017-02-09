ENV['MEDIA_ENV'] = "test"

require 'bundler/setup'

Bundler.setup

require 'simplecov'

SimpleCov.start

require 'pry'
require 'media_renamer'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }
