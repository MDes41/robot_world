require_relative '../test_helper'

class UserCanShowAllContentOfOneRobot < FeatureTest
  def test_user_can_show_all_content_of_one_robot
    create_dummy_information
    visit '/robots'
    first(:link, "Robot1").click
    save_and_open_page
    assert page.has_content?("1")
    assert page.has_content?("Robot1")
    assert page.has_content?("Denver")
    assert page.has_content?("CO")
    assert page.has_content?("12/06/1982")
    assert page.has_content?("8/17/2016")
    assert page.has_content?("Programming")
  end
end
