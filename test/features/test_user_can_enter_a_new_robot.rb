require_relative '../test_helper'

class UserCanEnterANewRobot < FeatureTest
  def test_user_can_enter_a_new_robot
    visit '/robots/new'
    fill_in('robot[name]', :with => "Robot1")
    fill_in('robot[city]', :with => "Denver")
    fill_in('robot[state]', :with => "CO")
    fill_in('robot[birthdate]', :with => "06/12/1982")
    fill_in('robot[date_hired]', :with => "17/08/2016")
    fill_in('robot[department]', :with => "Programming")
    click_button('submit')
    visit '/robots'
    assert page.has_content?("1")
    assert page.has_content?("Robot1")
  end
end
