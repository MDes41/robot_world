require_relative "../test_helper"

class RobotInventoryListsAllRobots < FeatureTest

  def create_robot1_test_data
    robot_inventory.create({
                            :name => "Robot1",
                            :city => "Denver",
                            :state => "CO",
                            :birthdate => "12/06/1982",
                            :date_hired => "17/08/2016",
                            :department => "Programming"
                          })

  end

  def create_robot2_test_data
    robot_inventory.create({
                            :name => "Robot2",
                            :city => "Chicago",
                            :state => "IL",
                            :birthdate => "12/06/1983",
                            :date_hired => "17/8/2015",
                            :department => "Paper Shredder"
                          })
  end

  def create_robot3_test_data
    robot_inventory.create({
                            :name => "Robot3",
                            :city => "Jacksonville",
                            :state => "FL",
                            :birthdate => "12/06/1984",
                            :date_hired => "17/8/2013",
                            :department => "Recycling"
                          })
  end

  def test_robot_inventory_lists_all_robots
    visit '/robots'

    refute page.has_content?("Robot1")
    refute page.has_content?("1")

    create_robot1_test_data
    visit '/robots'

    assert page.has_content?("Robot1")
    assert page.has_content?("1")
    refute page.has_content?("2")
    refute page.has_content?("Robot2")

    create_robot2_test_data
    visit '/robots'

    assert page.has_content?("2")
    assert page.has_content?("Robot2")
    refute page.has_content?("3")
    refute page.has_content?("Robot 3")

    create_robot3_test_data
    visit '/robots'

    assert page.has_content?("3")
    assert page.has_content?("Robot3")

  end
end
