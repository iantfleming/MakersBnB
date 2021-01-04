# require_relative 'app'
# require 'spec_helper'

feature 'setting up' do
  scenario 'homepage is set up' do
    visit '/'
    expect(page).to have_content('working!')
  end
end