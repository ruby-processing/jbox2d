# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pbox2d/version'

Gem::Specification.new do |spec|
  spec.name          = 'pbox2d'
  spec.version       = Pbox2d::VERSION
  spec.license       = 'FreeBSD/Simplified'
  spec.has_rdoc = true
  spec.extra_rdoc_files = ['README.md', 'LICENSE.md']
  spec.authors       = ['Martin Prout']
  spec.email         = ['martin_p@lineone.net']
  spec.summary       = %q{jbox2d wrapped in a gem for JRubyArt}
  spec.description   = <<-EOF
"An exemplar for how processing/java libraries can be made available for use 
in JRubyArt.  Features a maven build, also is an example of how to avoid an 
overdose of java reflection by letting jruby sugar implement an interface"
EOF
  spec.homepage      = 'https://github.com/ruby-processing/jbox2d'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files << 'lib/box2d.jar'
  spec.files << 'lib/jbox2d-library-2.3.1-SNAPSHOT.jar' 
  spec.require_paths = ['lib']
  spec.add_dependency 'jruby_art', '~> 1.0' 
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.platform='java'
  spec.requirements << 'A decent graphics card'
  spec.requirements << 'java runtime >= 1.8+'
  spec.requirements << 'processing = 3.0.1+'
  spec.requirements << 'maven = 3.3.3'
end
