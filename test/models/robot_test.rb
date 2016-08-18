require_relative "../test_helper"

class RobotTest < Minitest::Test
  def test_assigns_attributes_correctly
    robot = Robot.new({
      "id" => 1,
      "name" => "Joe",
      "city" => "Boston",
      "state" => "MA",
      "avatar" => "https://robohash.org/YOUR-TEXT.png",
      "birthdate" => "11-29-1991",
      "date_hired" => "11-29-2012",
      "department" => "medical"
      })

    assert_equal("Joe", robot.name)
    assert_equal(1, robot.id)
    assert_equal("Boston", robot.city)
    assert_equal("MA", robot.state)
    assert_equal("https://robohash.org/YOUR-TEXT.png", robot.avatar)
    assert_equal("11-29-1991", robot.birthdate)
    assert_equal("11-29-2012", robot.date_hired)
    assert_equal("medical", robot.department)
  end
end
