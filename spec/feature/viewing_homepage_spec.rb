# frozen_string_literal: true

# require_relative 'app'
# require 'spec_helper'
require './lib/listing.rb'
require 'pg'
# require 'pry'

feature 'setting up' do
  before(:each) do
    empty
    add_original_list
  end
  scenario 'A user can see site listings' do
    listing = Listing.create(name: 'London', price: 100, description: 'Wonderful one-bedroom apartment with falling ceilings', date: '2021-06-01', available_from: '2021-07-01', available_to: '2021-08-01', image: '/images/House1.jpeg')
    persisted_data = persisted_data(id: listing.id, table: 'listings')
    visit '/'
    # binding.pry
    expect(page).to have_content('London')
    expect(page).to have_content(100)
    expect(page).to have_content('Wonderful one-bedroom apartment with falling ceilings')
    expect(page).to have_content('2021-06-01')
    expect(page).to have_content('2021-07-01')
    expect(page).to have_content('2021-08-01')
  end
end
