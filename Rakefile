require 'rubygems'
require 'rake'
require 'echoe'
require 'rspec/core/rake_task'

Echoe.new('jquery_datepicker', '0.4') do |p|
  p.description    = "View helper that allows to select dates from a calendar (using jQuery Ui plugin)"
  p.url            = "http://github.com/albertopq/jquery_datepicker"
  p.author         = "Alberto Pastor"
  p.email          = "albert.pastor@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*", "spec/*"]
  p.development_dependencies = []
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec