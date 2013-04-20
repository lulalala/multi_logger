# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_logger/version'

Gem::Specification.new do |gem|
  gem.name          = "multi_logger"
  gem.version       = MultiLogger::VERSION
  gem.authors       = ["lulalala"]
  gem.email         = ["mark@goodlife.tw"]
  gem.description   = %q{Create multiple loggers in Rails.}
  gem.summary       = %q{Provide helper to define loggers and access them. Each logger will log into a different file under the log  folder.}

  gem.homepage      = "https://github.com/lulalala/multi_logger"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'railties'
end
