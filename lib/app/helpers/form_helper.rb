
module JqueryDatepicker
  module FormHelper
    
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates datepicker input field inside a form
    def datepicker(object_name, method, options = {})
      input_tag =  JqueryDatepicker::InstanceTag.new(object_name, method, self, options.delete(:object))
      dp_options, tf_options =  input_tag.split_options(options);
      new_options = input_tag.get_to_input_field_tag_options("text", tf_options)
      html = input_tag.tag("input", new_options)
      html += javascript_tag("jQuery(document).ready(function(){$('##{new_options["id"]}').datepicker(#{dp_options.to_json})});")
      html.html_safe
    end

  end

end

module JqueryDatepicker::FormBuilder
  def datepicker(method, options = {})
    @template.datepicker(@object_name, method, objectify_options(options))
  end
end

class JqueryDatepicker::InstanceTag < ActionView::Helpers::InstanceTag

  # Extending ActionView::Helpers::InstanceTag module to make Rails build the name and id
  # Just returns the options before generate the HTML in order to use the same id and name (see to_input_field_tag mehtod)
  
  def get_to_input_field_tag_options(field_type, options = {})
    options = options.stringify_keys
    options["size"] = options["maxlength"] || DEFAULT_FIELD_OPTIONS["size"] unless options.key?("size")
    options = DEFAULT_FIELD_OPTIONS.merge(options)
    if field_type == "hidden"
      options.delete("size")
    end
    options["type"]  ||= field_type
    options["value"] = options.fetch("value"){ value_before_type_cast(object) } unless field_type == "file"
    options["value"] &&= html_escape(options["value"])
    add_default_name_and_id(options)
    options
  end
  
  def available_datepicker_options
    [:disabled, :altField, :altFormat, :appendText, :autoSize, :buttonImage, :buttonImageOnly, :buttonText, :calculateWeek, :changeMonth, :changeYear, :closeText, :constrainInput, :currentText, :dateFormat, :dayNames, :dayNamesMin, :dayNamesShort, :defaultDate, :duration, :firstDay, :gotoCurrent, :hideIfNoPrevNext, :isRTL, :maxDate, :minDate, :monthNames, :monthNamesShort, :navigationAsDateFormat, :nextText, :numberOfMonths, :prevText, :selectOtherMonths, :shortYearCutoff, :showAnim, :showButtonPanel, :showCurrentAtPos, :showMonthAfterYear, :showOn, :showOptions, :showOtherMonths, :showWeek, :stepMonths, :weekHeader, :yearRange, :yearSuffix]
  end
  
  def split_options(options)
    tf_options = options.slice!(*available_datepicker_options)
    return options, tf_options
  end

end