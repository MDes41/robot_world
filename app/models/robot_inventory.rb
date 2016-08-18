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

  def age(dob)
    now = Time.now.utc.to_date
    parsed_dob = Time.parse(dob)
    now.year - parsed_dob.year - ((now.month > parsed_dob.month || (now.month == parsed_dob.month && now.day >= pased_dob.day)) ? 0 : 1)
  end

  def num_of_robots
    raw_robots.count
  end

  def ages
    raw_robots.map do |robot|
      age(robot["birthdate"])
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
end
