require 'date'

module JqueryDatepicker
  module FormHelper
    
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates datepicker input field inside a form
    def datepicker(object_name, method, options = {}, timepicker = false)
      input_tag =  JqueryDatepicker::InstanceTag.new(object_name, method, self, options.delete(:object))
      dp_options, tf_options =  input_tag.split_options(options, timepicker)
      
      if tf_options[:value] && !tf_options[:value].empty? && dp_options.has_key?(:dateFormat)
        if timepicker && dp_options.has_key?(:timeFormat)
          tf_options[:value] = input_tag.format_time(tf_options[:value], "#{ dp_options[:dateFormat] } #{dp_options[:timeFormat]}"))
        else
          tf_options[:value] = input_tag.format_date(tf_options[:value], String.new(dp_options[:dateFormat]))
        end
      end
      
      html = input_tag.to_input_field_tag("text", tf_options)
      method = timepicker ? "datetimepicker" : "datepicker"
      html += javascript_tag("jQuery(document).ready(function(){jQuery('##{input_tag.get_name_and_id["id"]}').#{method}(#{dp_options.to_json})});")
      html.html_safe
    end
    
  end

end

module JqueryDatepicker::FormBuilder
  def datepicker(method, options = {})
    @template.datepicker(@object_name, method, objectify_options(options))
  end
  
  def datetime_picker(method, options = {})
    @template.datepicker(@object_name, method, objectify_options(options), true)
  end
end

class JqueryDatepicker::InstanceTag < ActionView::Helpers::InstanceTag

  FORMAT_REPLACEMENTES = { "yy" => "%Y", "mm" => "%m", "dd" => "%d", "d" => "%-d", "m" => "%-m", "y" => "%y", "M" => "%b"}
  
  # Extending ActionView::Helpers::InstanceTag module to make Rails build the name and id
  # Just returns the options before generate the HTML in order to use the same id and name (see to_input_field_tag mehtod)
  
  def get_name_and_id(options = {})
    add_default_name_and_id(options)
    options
  end
  
  def available_datepicker_options(timepicker = false)
    opts = [:disabled, :altField, :altFormat, :appendText, :autoSize, :buttonImage, :buttonImageOnly, :buttonText, 
      :calculateWeek, :changeMonth, :changeYear, :closeText, :constrainInput, :currentText, :dateFormat, :dayNames, 
      :dayNamesMin, :dayNamesShort, :defaultDate, :duration, :firstDay, :gotoCurrent, :hideIfNoPrevNext, :isRTL, 
      :maxDate, :minDate, :monthNames, :monthNamesShort, :navigationAsDateFormat, :nextText, :numberOfMonths, 
      :prevText, :selectOtherMonths, :shortYearCutoff, :showAnim, :showButtonPanel, :showCurrentAtPos, 
      :showMonthAfterYear, :showOn, :showOptions, :showOtherMonths, :showWeek, :stepMonths, :weekHeader, 
      :yearRange, :yearSuffix]
    if timepicker
      opts.reverse_merge!([:currentText, :closeText, :ampm, :amNames, :pmNames, :timeFormat, :timeSuffix,
        :timeOnlyTitle, :timeText, :hourText, :minuteText, :secondText, :millisecText, :timezoneText, :showButtonPanel, 
        :timeOnly, :showHour, :showMinute, :showSecond, :showMillisec, :showTimezone, :showTime, :stepHour, :stepMinute, 
        :stepSecond, :stepMillisec, :hour, :minute, :second, :millisec, :timezone, :hourMin, :minuteMin, :secondMin, 
        :millisecMin, :hourMax, :minuteMax, :secondMax, :millisecMax, :minDateTime, :maxDateTime, :onSelect, :hourGrid, 
        :minuteGrid, :secondGrid, :millisecGrid, :alwaysSetTime, :separator, :altFieldTimeOnly, :showTimepicker, 
        :timezoneIso8609, :timezoneList, :addSliderAccess, :sliderAccessArgs])
    end
    opts
  end
  
  def split_options(options, timepicker = false)
    tf_options = options.slice!(*available_datepicker_options)
    return options, tf_options
  end
  
  def format_date(tb_formatted, format)
    new_format = translate_format(format)
    Date.parse(tb_formatted).strftime(new_format)
  end
  
  def format_time(tb_formatted, format)
    new_format = translate_format(format)
    Time.parse(tb_formatted).strftime(new_format)
  end

  # Method that translates the datepicker date formats, defined in (http://docs.jquery.com/UI/Datepicker/formatDate)
  # to the ruby standard format (http://www.ruby-doc.org/core-1.9.3/Time.html#method-i-strftime).
  # This gem is not going to support all the options, just the most used.
  
  def translate_format(format)
    format.gsub!(/#{FORMAT_REPLACEMENTES.keys.join("|")}/) { |match| FORMAT_REPLACEMENTES[match] }
  end

end