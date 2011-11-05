require 'app/helpers/form_helper'

module JqueryDatepicker
  module DatepickerHelper

    include JqueryDatepicker::FormHelper

    # Helper method that creates a datepicker input field
    def datepicker_input(object_name, method, options = {})
      datepicker(object_name, method, options)
    end
  
  end
end