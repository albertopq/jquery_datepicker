require 'pp'
require 'spec_helper'
require 'app/helpers/datepicker_helper'
require 'app/helpers/form_helper'
require 'date'

ActionView::Base.send(:include, JqueryDatepicker::DatepickerHelper)
ActionView::Helpers::FormBuilder.send(:include,JqueryDatepicker::FormBuilder)

current_value = Time.now

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
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D") %>
        EOTEMPLATE
    end
    
    let :datepicker_input_tf_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :tabindex => 70) %>
        EOTEMPLATE
    end
    
    let :datepicker_input_tf_and_dp_options_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D", :tabindex => 70) %>
        EOTEMPLATE
    end
    
    let :datepicker_input_dateFormat_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :dateFormat  => "yy-mm-dd", :minDate => -20, :maxDate => "+1M +10D", :value => "#{current_value.utc.to_s}") %>
        EOTEMPLATE
    end
    
    
    let :datepicker_input_with_value_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1, :value => "#{current_value.utc.to_s}") %>
        EOTEMPLATE
    end
    
    let :valid_response_javascript_with_options do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_att1').datepicker({\"dateFormat\":\"yy-mm-dd\",\"maxDate\":\"+1M +10D\",\"minDate\":-20})});\n//]]>\n</script>"
    end
    
    let :valid_response_input_with_options do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" tabindex=\"70\" type=\"text\" />"
    end
    
    let :valid_response_input_with_value do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.utc.to_s}\" />"
    end
    
    let :valid_response_input_with_value_formatted do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" value=\"#{current_value.strftime('%Y-%m-%d')}\" />"
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
    
    it "should format the date if both dateFormat and value params are set" do
      render :inline => datepicker_input_dateFormat_template
      rendered.strip.should == valid_response_input_with_value_formatted+valid_response_javascript_with_options
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
  
  describe JqueryDatepicker::InstanceTag do
    it "should return a valid format when translating yy-mm-dd" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("yy-mm-dd").should eq("%Y-%m-%d")
    end
    
    it "should return a valid format when translating mm-dd-yy" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("mm-dd-yy").should eq("%m-%d-%Y")
    end
    
    it "should return a valid format when translating m-d-y" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("m-d-y").should eq("%-m-%-d-%y")
    end
    
    it "should return a valid format when translating yy/m-dd" do
      input_tag =  JqueryDatepicker::InstanceTag.new("test", "method", "aux")
      input_tag.translate_format("yy/m-dd").should eq("%Y/%-m-%d")
    end
  end
end