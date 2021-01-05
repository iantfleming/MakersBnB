# frozen_string_literal: true

require 'sinatra/base'
require './lib/listing.rb'

class MakersBnb < Sinatra::Base
  enable :sessions

  get '/' do
    @listings = Listing.all
    erb :homepage
  end

  post '/click_to_rent' do
    @listings = Listing.all

    redirect '/room_rented'
  end

  get '/room_rented' do
    @listings = Listing.all
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