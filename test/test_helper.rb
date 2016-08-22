ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/pride'
require 'minitest/autorun'
require 'capybara/dsl'

module TestHelpers

  def teardown
    robot_inventory.delete_all
    super
  end

  # def robot_inventory
  #   database = YAML::Store.new("db/robot_inventory_test")
  #   @robot_inventory ||= RobotInventory.new(database)
  # end

  def robot_inventory
    database = SQLite3::Database.new("db/robot_inventory_test.db")
    database.results_as_hash = true
    RobotInventory.new(database)
  end

end

Capybara.app = RobotWorldApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
