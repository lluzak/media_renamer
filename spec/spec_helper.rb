require 'bundler/setup'

Bundler.setup

require 'simplecov'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start
SimpleCov.start

require 'pry'
require 'media_renamer'
