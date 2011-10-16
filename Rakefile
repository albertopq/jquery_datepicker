require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('jquery_datepicker', '0.1.0') do |p|
  p.description    = "View helper that allows to select dates from a calendar (using jQuery Ui plugin)"
  p.url            = "http://github.com/albertopq/jquery_datepicker"
  p.author         = "Alberto Pastor"
  p.email          = "albert.pastor@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }