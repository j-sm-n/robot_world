require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest
  def create_robot1
    robot_world.create({
      :name => "name test",
      :city => "city test",
      :state => "state test",
      :avatar => "https://robohash.org/YOUR-TEXT.png",
      :birthdate => "11-29-1991",
      :date_hired => "11-29-2012",
      :department => "test department"
      })
  end

  def create_robot2
    robot_world.create({
      :name => "BOB",
      :city => "AURORA",
      :state => "CO",
      :avatar => "https://robohash.org/YOUR.png",
      :birthdate => "01-22-1985",
      :date_hired => "09-29-2014",
      :department => "IT"
      })
  end

  def test_robots_displayed_properly
    create_robot1
    create_robot2

    visit '/robots'

    save_and_open_page

    assert page.has_content?('name test')
    assert page.has_content?('BOB')
  end
end
