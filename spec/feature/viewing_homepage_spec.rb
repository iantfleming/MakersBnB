# frozen_string_literal: true

# require_relative 'app'
# require 'spec_helper'
require './lib/listing.rb'
require 'pg'

# the test is failing because homepage.erb is empty
feature 'setting up' do
  scenario 'A user can see site listings' do
    Listing.new('London', 100, 'Wonderful one-bedroom apartment with falling ceilings')
    visit '/'
    expect(page).to have_content('London')
    expect(page).to have_content(100)
    expect(page).to have_content('Wonderful one-bedroom apartment with falling ceilings')
  end
end
