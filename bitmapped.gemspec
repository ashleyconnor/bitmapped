# -*- encoding: utf-8 -*-

require File.expand_path('../lib/bitmapped/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "bitmapped"
  gem.version       = Bitmapped::VERSION
  gem.summary       = %q{Bitmap CLI program}
  gem.description   = %q{Bitmap CLI program}
  gem.license       = "MIT"
  gem.authors       = ["Ashley Connor"]
  gem.email         = "ash.connor@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/bitmapped"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
