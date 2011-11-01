module FormHelper
  
  # Mehtod that generates datepicker input field inside a form
  def datepicker(att)
    model = self.object_name
    html = self.text_field att
    tag = '<script type="text/javascript">jQuery(document).ready(function(){$("#'+model+'_'+att.to_s+'").datepicker()});</script>'
    html << tag.html_safe
    return html
  end
  
end