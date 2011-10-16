# JqueryDatepicker
require "app/helpers/datepicker_helper.rb"
require "app/helpers/form_helper.rb"

%w{ helpers }.each do |dir| 
  ActionView::Base.send(:include, DatepickerHelper)
  ActionView::Helpers::FormBuilder.send(:include, FormHelper)
end