
class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get "/" do
    erb :dashboard
  end

  get "/robots" do
    @robots = robot_inventory.all
    erb :index
  end

  get "/robots/new" do
    erb :new
  end

  post "/robots" do
    robot_inventory.create(params[:robot])
    redirect '/robots'
  end

  get "/robots/:id" do |id|
    @robot = robot_inventory.find(id.to_i)
    erb :show
  end

  put "/robots/:id" do |id|
    robot_inventory.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  def robot_inventory
    if ENV["RACK_ENV"] == 'test'
      database = SQLite3::Database.new("db/robot_inventory_test.db,")
    else
      database = SQLite3::Database.new('db/robot_inventory_development.db')
    end
    database.results_as_hash = true
    RobotInventory.new(database)
  end

  get "/robots/:id/edit" do |id|
    @robot = robot_inventory.find(id.to_i)
    erb :edit
  end

  delete '/robots/:id' do |id|
    robot_inventory.destroy(id.to_i)
    redirect '/robots'
  end

  get '/robots/summary' do
    @ages = robot_inventory.ages
    @num_of_robots = robot_inventory.num_of_robots
    erb :summary
  end
end
