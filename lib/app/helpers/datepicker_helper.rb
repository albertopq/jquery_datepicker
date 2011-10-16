module DatepickerHelper
  
  # Helper method that creates a datepicker input field
  def datepicker_input(model, att)
    html = text_field(model,att)
    html += javascript_tag 'jQuery(document).ready(function(){$("#'+model.to_s+'_'+att.to_s+'").datepicker()});'
    return html
  end
  
end