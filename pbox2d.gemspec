# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pbox2d/version'

Gem::Specification.new do |spec|
  spec.name          = 'pbox2d'
  spec.version       = Pbox2d::VERSION
  spec.license       = 'BSD-2-Clause'
  spec.has_rdoc = true
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.authors       = ['Martin Prout']
  spec.email         = ['mamba2928@yahoo.co.uk']
  spec.summary       = %q{jbox2d wrapped in a gem for JRubyArt}
  spec.description   = <<-EOF
"An exemplar for making processing/java libraries available as a gem, for use 
in JRubyArt. Features a polyglot maven build, and also demonstrates how creating
an interface can avoid the need for explicit calls to java reflection."
EOF
  spec.homepage      = 'https://ruby-processing.github.io/jbox2d'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files << 'lib/box2d.jar'
  spec.require_paths = ['lib']
  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.platform='java'
end
