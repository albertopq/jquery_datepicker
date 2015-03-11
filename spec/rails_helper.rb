require 'active_support'
require 'active_record'
require 'active_support/deprecation'
require 'action_view'
require 'rails/all'
require 'rspec/rails/adapters'
require 'rspec/rails/example/rails_example_group'
require 'rspec/rails/matchers'
require 'rspec/rails/example/view_example_group'


plugin_spec_dir = File.dirname(__FILE__)
#ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

RSpec.configure do |c|
  c.include RSpec::Rails::ViewExampleGroup, :type => :view
end


# Class used in the tests to mock a model
class Foo
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end

  # Mocking an attribute
  def att1

  end
end