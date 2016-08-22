require_relative '../test_helper'

class UserCanShowAllContentOfOneRobot < FeatureTest

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

  def test_user_can_show_all_content_of_one_robot
    create_robot1_test_data

    visit '/robots'
    first(:link, "Robot1").click
    assert page.has_content?("1")
    assert page.has_content?("Robot1")
    assert page.has_content?("Denver")
    assert page.has_content?("CO")
    assert page.has_content?("12/06/1982")
    assert page.has_content?("17/08/2016")
    assert page.has_content?("Programming")
  end
end
