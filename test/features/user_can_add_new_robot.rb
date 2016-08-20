require_relative '../test_helper'

class UserCanAddRobotTest < FeatureTest
  def fill_robot_form
    fill_in('robot[name]', :with => 'John')
    fill_in('robot[city]', :with => 'AURORA')
    fill_in('robot[state]', :with => 'CO')
    fill_in('robot[avatar]', :with => '"https://robohash.org/YOUR-TEXT.png"')
    fill_in('robot[birthdate]', :with => '11-29-1991')
    fill_in('robot[date_hired]', :with => '05-05-2016')
    fill_in('robot[department]', :with => 'Gardening')
  end

  def test_user_can_submit_new_robot
    visit '/'
    click_on('Add New Robot')

    assert_equal '/robots/new', current_path

    fill_robot_form
    click_on('Submit')
    save_and_open_page

    assert_equal '/robots', current_path
    assert page.has_content?('AURORA')
  end
end
