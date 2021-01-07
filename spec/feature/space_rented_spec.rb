# frozen_string_literal: true

require './lib/listing.rb'
require 'pg'

# the test is failing because homepage.erb is empty
feature 'User is informed they have rented a space' do
  before(:each) do
    empty
    add_original_list
  end
  scenario 'A user rents the space' do
    visit '/'
    click_button('rent')
    expect(page).to have_content('You have rented London for £100')
  end
end
