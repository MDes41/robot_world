require_relative "../test_helper"

class RobotInventoryListsAllRobots < FeatureTest

  def test_robot_inventory_lists_all_robots
    visit '/robots'
    refute page.has_content?("matt")
    create_dummy_information
    visit '/robots'
    assert page.has_content?("matt")
    assert page.has_content?("1")
    assert page.has_content?("2")
    assert page.has_content?("3")
  end
end
