require_relative "../test_helper"

class RobotInventoryTest < Minitest::Test

  include TestHelpers

  def test_create_method_creates_robot_attributes
    create_dummy_information

    robot = robot_inventory.find(1)

    assert_equal 1, robot.id
    assert_equal "matt", robot.name
    assert_equal "denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "12/06/1982", robot.birthdate
    assert_equal "8/17/2016", robot.date_hired
    assert_equal "Programming", robot.department
  end

  def test_create_method_creates_two_robots
    create_dummy_information

    robot = robot_inventory.find(2)

    assert_equal 2, robot.id
    assert_equal "matt2", robot.name
    assert_equal "denver2", robot.city
    assert_equal "CO2", robot.state
    assert_equal "12/06/1983", robot.birthdate
    assert_equal "8/17/2015", robot.date_hired
    assert_equal "Programming2", robot.department
  end

  def test_ages_are_created_in_an_array
    create_dummy_information
    ages = robot_inventory.ages

    assert_equal [34, 33, 32], ages
  end

  def test_number_of_robots
    create_dummy_information
    assert_equal 3, robot_inventory.num_of_robots
  end

  def test_avg_age_calculates_avg
    create_dummy_information
    assert_equal 33, robot_inventory.avg_age
  end
end
