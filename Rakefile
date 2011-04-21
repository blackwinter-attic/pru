begin
  require 'jeweler'

  Jeweler::Tasks.new { |gem|
    gem.name     = 'pru'
    gem.summary  = 'Pipeable Ruby - forget about grep/sed/awk/wc... use pure, readable Ruby!'
    gem.email    = 'michael@grosser.it'
    gem.homepage = "http://github.com/grosser/#{gem.name}"
    gem.authors  = ['Michael Grosser']
  }

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler'
end

desc 'Run specs'
task :spec do
  sh 'rspec spec/'
end

task :default => :spec
