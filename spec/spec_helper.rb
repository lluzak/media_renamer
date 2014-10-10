require 'bundler/setup'

Bundler.setup

require 'simplecov'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start
SimpleCov.start

require 'pry'
require 'media_renamer'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }
