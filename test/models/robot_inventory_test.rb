require_relative "../test_helper"

class RobotInventoryTest < Minitest::Test

  include TestHelpers

  def create_robot1_test_data
    robot_inventory.create({
                            :name => "Robot1",
                            :city => "Denver",
                            :state => "CO",
                            :birthdate => "12/06/1982",
                            :date_hired => "17/08/2016",
                            :department => "Programming"
                          })

  end

  def create_robot2_test_data
    robot_inventory.create({
                            :name => "Robot2",
                            :city => "Chicago",
                            :state => "IL",
                            :birthdate => "12/06/1983",
                            :date_hired => "17/8/2015",
                            :department => "Paper Shredder"
                          })
  end

  def create_robot3_test_data
    robot_inventory.create({
                            :name => "Robot 3",
                            :city => "Jacksonville",
                            :state => "FL",
                            :birthdate => "12/06/1984",
                            :date_hired => "17/8/2013",
                            :department => "Recycling"
                          })
  end

  def test_create_method_creates_robot_attributes
    # skip
    create_robot1_test_data
    robot = robot_inventory.all.first

    assert_equal "Robot1", robot.name
    assert_equal "Denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "12/06/1982", robot.birthdate
    assert_equal "17/08/2016", robot.date_hired
    assert_equal "Programming", robot.department
  end

  def test_create_method_creates_two_robots
    # skip
    create_robot1_test_data
    create_robot2_test_data

    robot = robot_inventory.all.last

    assert_equal "Robot2", robot.name
    assert_equal "Chicago", robot.city
    assert_equal "IL", robot.state
    assert_equal "12/06/1983", robot.birthdate
    assert_equal "17/8/2015", robot.date_hired
    assert_equal "Paper Shredder", robot.department
  end

  def test_that_raw_robots_returns_an_array_of_hashes
    # skip
    create_robot1_test_data
    create_robot2_test_data

    data = robot_inventory.raw_robots

    assert_kind_of Array, data
    assert_kind_of Hash, data.pop
  end

  def test_all_method_returns_all_3_robots_with_data
    # skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    robots = robot_inventory.all

    assert_kind_of Array, robots
    assert_equal 3, robots.count
    assert_equal "Robot1", robots.first.name
    assert_equal "Denver", robots.first.city
    assert_equal "Robot 3", robots.last.name
    assert_equal "Jacksonville", robots.last.city
  end

  def test_find_by_id_works_for_robot_inventory
    # skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    robot3_id = robot_inventory.all.last.id

    assert_equal 'Robot 3', robot_inventory.find(robot3_id).name
  end

  def test_update_method_updates_robot_info_with_new_data
    # skip
    create_robot1_test_data

    robot = robot_inventory.all.first

    assert_equal "Robot1", robot.name
    robot_inventory.update(robot.id, { name: "New Name" })

    assert_equal "New Name", robot_inventory.find(robot.id).name
  end

  def test_avg_age_calculates_age_based_on_set_time_and_birthday
    # skip
    dob = "06/12/1982"
    now = Time.parse("18/08/2016")

    assert_equal 33, robot_inventory.age(dob, now)
  end

  def test_that_ages_calculates_on_each_robot
    # skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    now = Time.parse("18/08/2016")

    assert_kind_of Array, robot_inventory.ages(now)
    assert_equal [34, 33, 32], robot_inventory.ages(now)
  end

  def test_number_of_robots_calculated_all_the_robots_in_inventory
    # skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    assert_equal 3, robot_inventory.num_of_robots
  end

  def test_avg_age_calculates_avg
    # skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    robot_inventory.stub :ages, [10, 15, 20] do
      require "pry"; binding.pry
      assert_equal 15, robot_inventory.avg_age
    end
  end

  def test_delete_all_method_deletes_database_and_robot_info
    skip
    create_robot1_test_data
    create_robot2_test_data

    assert_equal 2, robot_inventory.all.count

    robot_inventory.delete_all

    assert_equal 0, robot_inventory.all.count
  end

  def test_robots_hire_date_from_large_to_small_organizes_robots_based_on_hire_date
    skip
    create_robot1_test_data
    create_robot2_test_data
    create_robot3_test_data

    assert_equal ["17/08/2016", "17/8/2015", "17/8/2013"], robot_inventory.strip_robot_hire_dates
  end

  def test_sorted_robot_hire_dates_by_year_sorts_robots_by_year
    skip
    hire_dates = ["17/8/2016", "17/08/2015", "17/8/2013"]
    result = robot_inventory.sorted_robot_hire_dates(hire_dates)

    assert_equal [2013, 2014, 2015, 2016], result
  end

  def test_spread_spreads_years_over_certain_amount_of_years
    skip
    robot_inventory.stub :robots_hire_date_spread, (1..30).to_a do
      hire_dates_spread = robot_inventory.robots_hire_date_spread
      assert_equal [1, 16, 30], hire_dates_spread.spread(3)
    end
  end

  def test_robots_hire_date_spread_gets_array_of_five_years_or_less
    skip
    hire_dates = [2013, 2014, 2015, 2016]
    assert_equal 4, robot_inventory.robots_hire_date_spread(hire_dates).count
    hire_dates = (2010..2020).to_a
    assert_equal 5, robot_inventory.robots_hire_date_spread(hire_dates).count
    assert_equal [2010, 2012, 2015, 2018, 2020], robot_inventory.robots_hire_date_spread(hire_dates)
  end

  def test_robots_hire_date_spread_gives_back_an_array_of_years
    skip

  end

end
