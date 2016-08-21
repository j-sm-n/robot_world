require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.last.id
  end

  def create_robot
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

  def number_of_robots
    robot_world.all.count
  end

  def test_it_can_create_a_robot
    assert_equal(0, number_of_robots)

    create_robot
    # robot = robot_world.find(current_robot_id)

    assert_equal(1, number_of_robots)
    # assert_equal("name test", robot.name)
    # assert_equal("city test", robot.city)
    # assert_equal("state test", robot.state)
    # assert_equal("https://robohash.org/YOUR-TEXT.png", robot.avatar)
    # assert_equal("11-29-1991", robot.birthdate)
    # assert_equal("11-29-2012", robot.date_hired)
    # assert_equal("test department", robot.department)
  end

  def test_it_returns_all_robots
    create_robot
    create_robot

    assert_equal(2, number_of_robots)
    assert_instance_of(Robot, robot_world.all.first)
  end

  def test_it_finds_a_robot
    create_robot
    robot = robot_world.find(current_robot_id)

    assert_instance_of(Robot, robot)
  end

  def test_it_deletes_a_robot
    create_robot

    assert_equal(1, number_of_robots)

    robot_world.destroy(current_robot_id)

    assert_equal(0, number_of_robots)
  end

  def test_it_updates_a_robot
    create_robot
    params = {robot: {name: "Bob", city: "Aurora", state: "CO", avatar: "https://robohash.org/YOUR-TEXT.png", birthdate: "11-29-1985", date_hired: "11-29-2012", department: "IT"}}
    robot_world.update(current_robot_id, params[:robot])
    robot = robot_world.find(current_robot_id)

    assert_equal("Bob", robot.name)
    assert_equal("Aurora", robot.city)
    assert_equal("CO", robot.state)
    assert_equal("https://robohash.org/YOUR-TEXT.png", robot.avatar)
    assert_equal("1985-11-29", robot.birthdate)
  end

  def test_it_groups_robots_on_dept
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Erie",
      :state => "CO",
      :birthday => "08-26-2016",
      :date_hired => "08-29-2016",
      :department => "Home Science"
      })

    assert_equal [{"department"=>"Home Science", "COUNT(id)"=>1, 0=>"Home Science", 1=>1}, {"department"=>"test department", "COUNT(id)"=>1, 0=>"test department", 1=>1}], robot_world.group_by_department
  end

  def test_it_groups_by_hire_year
    create_robot
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "08-26-2016",
      :date_hired => "08-29-2015",
      :department => "Home Science"
      })
    robot_world.create({
      :name => "New Robot",
      :city => "Newton",
      :state => "NJ",
      :birthday => "08-26-2016",
      :date_hired => "08-29-2014",
      :department => "Home Science"
      })

    # fix this test
    assert_equal [{"strftime('%Y', date_hired)"=>"2014", "COUNT(id)"=>3, 0=>"2014", 1=>3}], robot_world.group_by_hire_year
  end
end
