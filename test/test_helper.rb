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

  def create_dummy_information
    robot_inventory.create({
                            :id => 1,
                            :name => "Robot1",
                            :city => "Denver",
                            :state => "CO",
                            :birthdate => "12/06/1982",
                            :date_hired => "8/17/2016",
                            :department => "Programming"
                          })
    robot_inventory.create({
                            :id => 2,
                            :name => "Robot2",
                            :city => "Chicago",
                            :state => "IL",
                            :birthdate => "12/06/1983",
                            :date_hired => "8/17/2015",
                            :department => "Paper Shredder"
                          })
    robot_inventory.create({
                            :id => 3,
                            :name => "Robot 3",
                            :city => "Jacksonville",
                            :state => "FL",
                            :birthdate => "12/06/1984",
                            :date_hired => "8/17/2013",
                            :department => "Recycling"
                          })
  end

  def robot_inventory
    database = YAML::Store.new("db/robot_inventory_test")
    @robot_inventory ||= RobotInventory.new(database)
  end

end

Capybara.app = RobotWorldApp

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
