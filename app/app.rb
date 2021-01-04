require 'sinatra/base'

class MakersBnb < Sinatra::Base    
  get '/' do
    'working!'
  end

  run! if app_file == $0
end
