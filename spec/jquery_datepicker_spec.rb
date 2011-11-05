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
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_var_att1').datepicker()});\n//]]>\n</script>"
    end

   let :valid_response_input do
      "<input id=\"foo_att1\" name=\"foo[att1]\" size=\"30\" type=\"text\" />"
    end

    let :valid_response_javascript do
      "<script type=\"text/javascript\">\n//<![CDATA[\njQuery(document).ready(function(){$('#foo_att1').datepicker()});\n//]]>\n</script>"
    end

  describe JqueryDatepicker::DatepickerHelper, :type => :view do

    let :datepicker_input_template do
        <<-EOTEMPLATE
          <%= datepicker_input(:foo, :att1) %>
        EOTEMPLATE
    end

    it "should return a valid code when calling from the helper" do
      render :inline => datepicker_input_template
      rendered.strip.should == valid_response_input+valid_response_javascript
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