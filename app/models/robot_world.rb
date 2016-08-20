require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.execute("INSERT INTO robots
                    (name, city, state, avatar, birthdate, date_hired, department)
                    VALUES
                      ('#{robot[:name]}', '#{robot[:city]}', '#{robot[:state]}', '#{robot[:avatar]}', '#{robot[:birthdate]}', '#{robot[:date_hired]}', '#{robot[:department]}');"
                    )
  end

  def raw_robots
    database.execute("SELECT * FROM robots;")
  end

  def all
    raw_robots.map { |row| Robot.new(row) }
  end

  def raw_robot(id)
    database.execute("SELECT * FROM robots WHERE id=?;", id).first
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot_data)
    database.execute("UPDATE robots
                      SET name=?,
                      city=?,
                      state=?,
                      avatar=?,
                      birthdate=?,
                      date_hired=?,
                      department=?
                      WHERE id=?;",
                      robot_data[:name],
                      robot_data[:city],
                      robot_data[:state],
                      robot_data[:avatar],
                      robot_data[:birthdate],
                      robot_data[:date_hired],
                      robot_data[:department], id
                    )
  end

  def destroy(id)
    database.execute("DELETE FROM robots
                      WHERE id=?;", id
                    )
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end

  def average_age

  end

  def robots_hired_per_year

  end

  def all_robots_by_state

  end

  def all_robots_by_city

  end

  def all_robots_by_department

  end

end
