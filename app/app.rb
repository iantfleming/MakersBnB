# frozen_string_literal: true

require 'sinatra/base'
require './lib/listing.rb'

class MakersBnb < Sinatra::Base
  enable :sessions

  get '/' do
    @listings = Listing.all
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
    Listing.create(name: params[:name], price: params[:price], description: params[:description])
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
