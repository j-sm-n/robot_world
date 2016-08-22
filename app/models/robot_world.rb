require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def format_date(date_param)
    if date_param
      n = date_param.split('-')
      formatted = "#{n[2]}-#{n[0]}-#{n[1]}"
    else
      date_param
    end
  end

  def create(robot)
    database.execute("INSERT INTO robots
                    (name, city, state, avatar, birthdate, date_hired, department)
                    VALUES
                      ('#{robot[:name]}',
                      '#{robot[:city]}',
                      '#{robot[:state]}',
                      '#{robot[:avatar]}',
                      '#{format_date(robot[:birthdate])}',
                      '#{format_date(robot[:date_hired])}',
                      '#{robot[:department]}');"
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
                      format_date(robot_data[:birthdate]),
                      format_date(robot_data[:date_hired]),
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


  def group_by_department
    database.execute("SELECT department, COUNT(id) FROM robots GROUP BY department;")
  end

  def group_by_hire_year
    database.execute("SELECT strftime('%Y', date_hired), COUNT(id) FROM robots GROUP BY strftime('%Y', date_hired);")
  end

  def group_by_state

  end

  def group_by_city

  end

  def get_robot_average_age

  end
end
