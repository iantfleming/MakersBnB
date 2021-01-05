# frozen_string_literal: true

require 'sinatra/base'
require './lib/listing.rb'

class MakersBnb < Sinatra::Base
  get '/' do
    @listings = Listing.all
    erb :homepage
  end

  run! if app_file == $PROGRAM_NAME
end
