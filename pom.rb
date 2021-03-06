require 'fileutils'
project 'pbox2d', 'https://github.com/ruby-processing/jbox2d' do

  model_version '4.0.0'
  id 'ruby-processing:pbox2d', '1.0.5'
  packaging 'jar'

  description 'jbox2d for JRubyArt and propane'

  organization 'ruby-processing', 'https://ruby-processing.github.io'

  developer 'monkstone' do
    name 'Martin Prout'
    email 'mamba2928@yahoo.co.uk'
    roles 'developer'
  end

  license 'BSD-2-clause', 'http://www.opensource.org/licenses/bsd-license.php'

  issue_management 'https://github.com/ruby-processing/jbox2d/issues', 'Github'

  source_control(
    :url => 'https://github.com/ruby-processing/jbox2d',
    :connection => 'scm:git:git://github.com/ruby-processing/jbox2d.git',
    :developer_connection => 'scm:git:git@github.com/ruby-processing/jbox2d.git'
  )

  properties( 'maven.compiler.source' => '1.8',
              'project.build.sourceEncoding' => 'UTF-8',
              'maven.compiler.target' => '1.8',
              'polyglot.dump.pom' => 'pom.xml',
              'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
              'jruby.api' => "http://jruby.org/apidocs/"
            )


  pom 'org.jruby:jruby:9.2.6.0'
  jar 'org.processing:core:3.3.7'

  plugin_management do
    plugin :resources, '2.6'
    plugin :dependency, '2.8'
    plugin(
          :compiler, '3.8.0',
          source: '${maven.compiler.source}',
          target: '${maven.compiler.target}'
          )
    plugin( :javadoc, '2.10.4',
          'detectOfflineLinks' => 'false',
          'links' => ['${processing.api}', '${jruby.api}']
          )
    plugin( :jar, '3.0.2',
            'archive' => {
              'manifestFile' => 'MANIFEST.MF'
            }
          )
  end
  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'box2d'
  end
end
