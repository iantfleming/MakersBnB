require 'sinatra/base'
require './lib/listing.rb'

class MakersBnb < Sinatra::Base
  get '/' do
    # @listings = Listing.all
    # p @listings
    erb :homepage
  end

  run! if app_file == $0
end
