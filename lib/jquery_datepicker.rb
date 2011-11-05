# JqueryDatepicker
require "app/helpers/datepicker_helper.rb"
require "app/helpers/form_helper.rb"

module JqueryDatepicker
  class Railtie < Rails::Railtie
    initializer "JqueryDatepicker" do
      ActionController::Base.helper(JqueryDatepicker::DatepickerHelper)
      ActionView::Helpers::FormHelper.send(:include, JqueryDatepicker::FormHelper)
      ActionView::Base.send(:include, JqueryDatepicker::DatepickerHelper)
      ActionView::Helpers::FormBuilder.send(:include,JqueryDatepicker::FormBuilder)
    end
  end
end
