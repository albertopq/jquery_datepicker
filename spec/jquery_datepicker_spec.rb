require 'pp'
require 'spec_helper'
require 'app/helpers/datepicker_helper'
require 'app/helpers/form_helper'

ActionView::Base.send(:include, JqueryDatepicker::DatepickerHelper)
ActionView::Helpers::FormBuilder.send(:include,JqueryDatepicker::FormBuilder)

describe JqueryDatepicker do

   let :valid_nested_response_input do
      "<input id=\"foo_var_att1\" name=\"foo[var][att1]\" size=\"30\" type=\"text\" />"
    end

    let :valid_nested_response_javascript do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_var_att1').datepicker({})});\n//]]>\n</script>"
    end

   let :valid_response_input do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" />"
    end

    let :valid_response_javascript do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_att1').datepicker({})});\n//]]>\n</script>"
    end

  describe JqueryDatepicker::DatepickerHelper, :type => :view do

    let :datepicker_input_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1) %>
        EOTEMPLATE
    end
    
    let :datepicker_input_dp_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :minDate => -20, :maxDate => "+1M +10D") %>
        EOTEMPLATE
    end
    
    let :datepicker_input_tf_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :tabindex => 70) %>
        EOTEMPLATE
    end
    
    let :datepicker_input_tf_and_dp_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :minDate => -20, :maxDate => "+1M +10D", :tabindex => 70) %>
        EOTEMPLATE
    end
    
    let :datepicker_input_with_value_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :value => "value") %>
        EOTEMPLATE
    end
    
    let :valid_response_javascript_with_options do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_att1').datepicker({\"maxDate\":\"+1M +10D\",\"minDate\":-20})});\n//]]>\n</script>"
    end
    
    let :valid_response_input_with_options do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" tabindex=\"70\" type=\"text\" />"
    end
    
    let :valid_response_input_with_value do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"value\" />"
    end

    it "should return a valid code when calling from the helper" do
      render :inline => datepicker_input_template
      rendered.strip.should == valid_response_input+valid_response_javascript
    end
    
    it "should use the jQuery datepicker options" do
      render :inline => datepicker_input_dp_options_template
      rendered.strip.should == valid_response_input+valid_response_javascript_with_options
    end
    
    it "should use the text_field options" do
      render :inline => datepicker_input_tf_options_template
      rendered.strip.should == valid_response_input_with_options+valid_response_javascript
    end
    
    it "should put each option on the correct place when sending Datepicker and textfield options" do
      render :inline => datepicker_input_tf_and_dp_options_template
      rendered.strip.should == valid_response_input_with_options+valid_response_javascript_with_options
    end
    
    it "should work when sending the value on the options" do
      render :inline => datepicker_input_with_value_template
      rendered.strip.should == valid_response_input_with_value+valid_response_javascript
    end

  end

  describe JqueryDatepicker::FormHelper, :type => :view do

    let :foo do
      Foo.new
    end

    let :datepicker_form_template do
        <<-EOTEMPLATE
          <%= form_for(foo, :url => "fake") do |f| %>
            <%= f.datepicker(:att1) %>
          <% end %>
        EOTEMPLATE
    end

    let :datepicker_nested_form_template do
        <<-EOTEMPLATE
          <%= form_for(foo, :url => "fake") do |f| %>
            <%= f.fields_for :var do |f2| %>
              <%= f2.datepicker(:att1) %>
            <% end %>
          <% end %>
        EOTEMPLATE
    end



    it "should return a valid response when calling inside a form_for" do
      render :inline => datepicker_form_template , :locals => {:foo => foo}
      rendered.should include(valid_response_input)
      rendered.should include(valid_response_javascript)
    end

    it "should return a valid response when calling inside a nested form_form" do
      render :inline => datepicker_nested_form_template,:locals  => {:foo => foo}
      rendered.should include(valid_nested_response_input)
      rendered.should include(valid_nested_response_javascript)
    end

  end
end