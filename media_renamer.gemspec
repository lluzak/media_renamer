# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'media_renamer/version'

Gem::Specification.new do |spec|
  spec.name          = "media_renamer"
  spec.version       = MediaRenamer::VERSION
  spec.authors       = ["Przemek Lusar"]
  spec.email         = ["lluzak@gmail.com"]
  spec.description   = "Renames downloaded media files into xmbc naming convention"
  spec.summary       = "Media Renamer"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "rb-inotify", "~> 0.9" if RUBY_PLATFORM =~ /linux/i
  spec.add_dependency "rb-fsevent", "~> 0.9" if RUBY_PLATFORM =~ /darwin/i

  spec.add_dependency "titleize", "~> 1.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  end
