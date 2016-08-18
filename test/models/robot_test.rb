require_relative "../test_helper"

class RobotTest < Minitest::Test

  def test_robot_creates_all_attributes
    robot = Robot.new({
                        "id" => 1,
                        "name" => "matt",
                        "city" => "denver",
                        "state" => "CO",
                        "birthdate" => "12/06/1982",
                        "date_hired" => "8/17/2016",
                        "department" => "Programming"
                      })

    assert_equal 1, robot.id
    assert_equal "matt", robot.name
    assert_equal "denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "12/06/1982", robot.birthdate
    assert_equal "8/17/2016", robot.date_hired
    assert_equal "Programming", robot.department
  end
end
