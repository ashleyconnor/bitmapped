# encoding: utf-8

require File.expand_path('../lib/bitmapped/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "bitmapped"
  gem.version       = Bitmapped::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.summary       = %q{Bitmap CLI program}
  gem.description   = %q{Bitmap CLI program}
  gem.license       = "MIT"
  gem.authors       = ["Ashley Connor"]
  gem.email         = "ashconnor@me.com"
  gem.homepage      = "https://rubygems.org/gems/bitmapped"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = ">= 2.0.0"
  gem.add_runtime_dependency 'terminal-table', '~> 1.4', '>= 1.4.5'
end
