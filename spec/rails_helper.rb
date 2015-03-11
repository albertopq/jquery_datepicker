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

  # rspec-rails 3 will no longer automatically infer an example group's spec type
  # from the file location. You can explicitly opt-in to the feature using this
  # config option.
  # To explicitly tag specs without using automatic inference, set the `:type`
  # metadata manually:
  #
  #     describe ThingsController, :type => :controller do
  #       # Equivalent to being in spec/controllers
  #     end
  # c.infer_spec_type_from_file_location!
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