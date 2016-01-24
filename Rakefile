require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'rake/testtask'

require_relative 'lib/pbox2d/version'

def create_manifest
  title =  'Implementation-Title: box2d (pbox2d java extension for JRubyArt)'
  version =  format('Implementation-Version: %s', Pbox2d::VERSION)   
  file = File.open('MANIFEST.MF', 'w') do |f|
    f.puts(title)
    f.puts(version)
  end
end

task default: [:init, :compile, :gem]

desc 'Create Manifest'
task :init do
  create_manifest
end

desc 'Compile'
task :compile do
  sh "mvn package"
  sh "mv target/box2d.jar lib"
end

desc 'Build Gem'
task :gem do
 sh "gem build pbox2d.gemspec"
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end
