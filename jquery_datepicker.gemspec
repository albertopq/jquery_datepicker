# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jquery_datepicker"
  s.version = "0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alberto Pastor"]
  s.date = "2011-11-07"
  s.description = "View helper that allows to select dates from a calendar (using jQuery Ui plugin)"
  s.email = "albert.pastor@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "lib/app/helpers/datepicker_helper.rb", "lib/app/helpers/form_helper.rb", "lib/jquery_datepicker.rb"]
  s.files = ["README.rdoc", "Rakefile", "init.rb", "jquery_datepicker.gemspec", "lib/app/helpers/datepicker_helper.rb", "lib/app/helpers/form_helper.rb", "lib/jquery_datepicker.rb"]
  s.homepage = "http://github.com/albertopq/jquery_datepicker"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Jquery_datepicker", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "jquery_datepicker"
  s.rubygems_version = "1.8.10"
  s.summary = "View helper that allows to select dates from a calendar (using jQuery Ui plugin)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
