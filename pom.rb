require 'fileutils'
project 'pbox2d', 'https://github.com/ruby-processing/jbox2d' do

  model_version '4.0.0'
  id 'ruby-processing:pbox2d', '1.0.6'
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

  properties(
              'project.build.sourceEncoding' => 'UTF-8',
              'polyglot.dump.pom' => 'pom.xml',
              'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
              'jruby.api' => "http://jruby.org/apidocs/"
            )


  jar 'org.jruby:jruby-base:9.3.0.0'
  jar 'org.processing:core:4.0.0'

  overrides do
    plugin :resources, '3.1.0'
    plugin :dependency, '3.1.2'
    plugin(:compiler, '3.8.1',
           'release' => '11')
    plugin(:javadoc, '2.10.4',
           'detectOfflineLinks' => 'false',
           'links' => ['${processing.api}',
                       '${jruby.api}'])
    plugin(:jar, '3.2.0')
    plugin :jdeps, '3.1.2' do
      execute_goals 'jdkinternals', 'test-jdkinternals'
    end
  end


  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'box2d'
  end
end
