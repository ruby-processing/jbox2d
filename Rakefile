require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'rdoc/task'
require 'rake/testtask'
require 'rspec/core/rake_task'
require_relative 'lib/pbox2d/version'

spec = Gem::Specification.new do |s|
  s.name = 'pbox2d'
  s.version = Pbox2D::VERSION
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE.md']
  s.summary = 'jbox2d wrapped in a gem for ruby-processing'
  s.description = <<-EOF
"An exemplar for how processing/java libraries can be made available
for use in ruby-processing. In this example avoiding an overdose of java 
reflection by letting jruby sugar implement an interface"
EOF
  s.license = 'MIT'
  s.authors = ['Martin Prout']
  s.email = 'martin_p@lineone.net'
  s.homepage = 'https://github.com/ruby-processing/jbox2d'
  s.files = %w(LICENSE.md README.md Rakefile) + FileList['lib/**/*.rb', 'example/**/*.rb']
  s.files << 'lib/box2d.jar'
  s.files << 'lib/jbox2d-library-2.2.1-ds.jar' 
  s.require_path = 'lib'
  s.add_dependency "ruby-processing", "~> 2.6.4"
  s.add_development_dependency "rake", "~> 10.3"
  s.add_development_dependency "rake-compiler", "~> 0.9"
  s.platform='java'
  s.requirements << 'A decent graphics card'
  s.requirements << 'java runtime >= 1.7+'
  s.requirements << 'processing = 2.2.1+'
end

# -*- ruby -*-

require 'java'
require 'rake/javaextensiontask'

# -*- encoding: utf-8 -*-
require 'psych'

def copy_jars(name, dest)
  conf = '~/.jruby_art/config.yml'
  begin
    path = File.expand_path(conf)
    rp_config = (Psych.load_file(path))
    source= "#{rp_config["PROCESSING_ROOT"]}/core/library/"    
  rescue
    raise "WARNING: you must set PROCESSING_ROOT in #{conf} compile"
  end
	body = proc {
	  Dir["#{source}/core.jar"].each do |f|
	    puts "Copying #{f} To #{dest}"
	    FileUtils.cp f, dest
	  end
	}
	Rake::Task.define_task(name, &body)	
end

copy_jars(:processing_jars, 'lib')

Rake::JavaExtensionTask.new('processing') do |ext|
  jars = FileList['lib/*.jar']
  ext.classpath = jars.map { |x| File.expand_path x}.join ':'
  ext.name = 'box2d'
  ext.debug = true
  ext.lib_dir = 'lib'
  ext.source_version='1.7'
  ext.target_version='1.7'
end

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files = ['README.md', 'LICENSE.md'] + FileList['lib/**/*.rb']
  
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.md" # page to start on
  rdoc.title = "Box2D Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = [Dir["lib"].to_a.join(':')]
end


