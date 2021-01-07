# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require './lib/listing.rb'
require './lib/user.rb'

class MakersBnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @listings = Listing.all
    p @listings
    erb :homepage
  end

  post '/click_to_rent/:id' do
    session[:list_id] = params[:id]
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("SELECT * FROM listings WHERE id = '#{params[:id]}'")
    redirect '/room_rented/:id'
  end

  get '/room_rented/:id' do
    @listing = Listing.find(id: session[:list_id])
    # @listings = Listing.all
    # @list_id = session[:list_id]
    erb :room_rented
  end

  get '/list_new_room' do
    erb :list_new_room
  end

  post '/list_new_room' do
    if params[:image] && params[:image][:filename]
      Listing.create(name: params[:name], price: params[:price], description: params[:description], image: params[:image][:filename])
      filename = params[:image][:filename]
      file = params[:image][:tempfile]
      path = "./public/images/#{filename}"
      File.open(path, 'wb') do |f|
        f.write(file.read)
      end
    else
      Listing.create(name: params[:name], price: params[:price], description: params[:description])
    end
    redirect '/'
  end

  post '/register' do
    user = User.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], password: params[:password])
    flash[:notice] = "Thank you for registering with MakersBnB, #{user.firstname}"
    redirect '/'
  end

  get '/register' do
    erb :registration
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.login(email: params[:email], password: params[:password])
    if user
      flash[:notice] = "Welcome, #{user.firstname}"
      redirect '/'
    else
      flash[:notice] = 'The email or password is incorrect. Please try again.'
      redirect '/login'
    end
  end

  run! if app_file == $PROGRAM_NAME
end
