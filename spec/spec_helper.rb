require 'bundler/setup'

Bundler.setup

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'pry'
require 'media_renamer'
