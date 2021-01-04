# require_relative 'app'
# require 'spec_helper'
require './lib/listing.rb'
require 'pg'

feature 'setting up' do
  scenario 'A user can see site listings' do
    Listing.new('London', '1000000', "Wonderful one-bedroom apartment with falling ceilings")
    visit '/'
  #   expect(page).to have_content("London") 
  #   expect(page).to have_content('1000000') 
  #   expect(page).to have_content('Wonderful one-bedroom apartment with falling ceilings') 
  end
end