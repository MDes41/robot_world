require 'models/robot_inventory'

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
    database = YAML::Store.new('db/robot_inventory')
    @robot_inventory ||= RobotInventory.new(database)
  end

  get "/robots/:id/edit" do |id|
    @robot = robot_inventory.find(id.to_i)
    erb :edit
  end

end
