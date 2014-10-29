require 'date'

module JqueryDatepicker
  module FormHelper
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates datepicker input field inside a form
    def datepicker(object_name, method, options = {}, timepicker = false)
      input_tag = JqueryDatepicker::InstanceTag.new(object_name, method, self, options.merge(type: "text"))
      html = input_tag.render
      method = timepicker ? "datetimepicker" : "datepicker"
      html += javascript_tag("jQuery(document).ready(function(){jQuery('##{input_tag.get_id}').#{method}(#{input_tag.dp_options.to_json})});")
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

class JqueryDatepicker::InstanceTag < ActionView::Helpers::Tags::TextField

  FORMAT_REPLACEMENTES = { "yy" => "%Y", "mm" => "%m", "dd" => "%d", "d" => "%-d", "m" => "%-m", "y" => "%y", "M" => "%b"}
  attr_reader :dp_options

  # Intialize a TextField without all the DatePicker attributes and simple store the DatePicker attributes
  def initialize(object_name, method_name, template_object, options = {})
    dp_options, tf_options = split_options(options)
    tf_options[:value] = format_date(tf_options[:value], String.new(dp_options[:dateFormat])) if tf_options[:value] && !tf_options[:value].empty? && dp_options.has_key?(:dateFormat)
    super(object_name, method_name, template_object, tf_options)
    @dp_options = dp_options
  end

  # Tags::TextField render already calls add_default_name_and_id but doesn't modify the instance @options, so call it here to ensure we calculate the same id attribute
  def get_id
    options = @options.stringify_keys
    add_default_name_and_id(options)
    options['id']
  end

  def available_datepicker_options
    [:disabled, :altField, :altFormat, :appendText, :autoSize, :buttonImage, :buttonImageOnly, :buttonText, :calculateWeek, :changeMonth, :changeYear, :closeText, :constrainInput, :currentText, :dateFormat, :dayNames, :dayNamesMin, :dayNamesShort, :defaultDate, :duration, :firstDay, :gotoCurrent, :hideIfNoPrevNext, :isRTL, :maxDate, :minDate, :monthNames, :monthNamesShort, :navigationAsDateFormat, :nextText, :numberOfMonths, :prevText, :selectOtherMonths, :shortYearCutoff, :showAnim, :showButtonPanel, :showCurrentAtPos, :showMonthAfterYear, :showOn, :showOptions, :showOtherMonths, :showWeek, :stepMonths, :weekHeader, :yearRange, :yearSuffix]
  end

  def split_options(options)
    tf_options = options.slice!(*available_datepicker_options)
    return options, tf_options
  end

  def format_date(tb_formatted, format)
    new_format = translate_format(format)
    Date.parse(tb_formatted).strftime(new_format)
  end

  # Method that translates the datepicker date formats, defined in (http://docs.jquery.com/UI/Datepicker/formatDate)
  # to the ruby standard format (http://www.ruby-doc.org/core-1.9.3/Time.html#method-i-strftime).
  # This gem is not going to support all the options, just the most used.

  def translate_format(format)
    format.gsub!(/#{FORMAT_REPLACEMENTES.keys.join("|")}/) { |match| FORMAT_REPLACEMENTES[match] }
  end

end
