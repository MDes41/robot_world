require 'yaml/store'
require_relative 'robot'
require 'time'

class RobotInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database["robots"] << { "id" => database['total'],
                              "name" => robot[:name],
                              "city" => robot[:city],
                              "state" => robot[:state],
                              "birthdate" => robot[:birthdate],
                              "date_hired" => robot[:date_hired],
                              "department" => robot[:department]
                            }
    end
  end

  def raw_robots
    database.transaction do
      database["robots"] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    database.transaction do
      target = database['robots'].find { |data| data["id"] == id }
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot['id'] == id }
    end
  end

  def age(dob, now = Time.now.utc.to_date)
    parsed_dob = Time.parse(dob)
    now.year - parsed_dob.year - ((now.month > parsed_dob.month || (now.month == parsed_dob.month && now.day >= pased_dob.day)) ? 0 : 1)
  end

  def num_of_robots
    raw_robots.count
  end

  def ages(now = Time.now.utc.to_date)
    raw_robots.map do |robot|
      age(robot["birthdate"], now)
    end
  end

  def avg_age
    ages.reduce(:+)/num_of_robots
  end

  def delete_all
    database.transaction do
      database['robots'] = []
      database["total"] = 0
    end
  end

  def strip_robot_hire_dates
    all.map { |robot| robot.date_hired }
  end

  def sorted_robot_hire_dates(hire_dates)
    years = hire_dates.map { |hire_date| Time.parse(hire_date).year }
    (years.min..years.max).to_a
  end

  def robots_hire_date_spread(hire_dates)
    if hire_dates.count <= 5
      hire_dates
    else
      hire_dates.spread(5)
    end
  end

  def robot_hired_per_year
   
  end

  def number_of_robots_in_each_department

  end

  def number_of_robots_in_each_city
  end

  def number_of_robots_in_each_state

  end


end

class Array
  def spread(n)
    step = self.length.to_f / (n - 1)
    (0..(n-2)).to_a.map { |i| self[i * step]} + [self.last]
  end
end
