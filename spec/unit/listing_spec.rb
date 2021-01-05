# frozen_string_literal: true

require 'listing'

RSpec.describe 'Listing' do
  it 'should have a name, price, description' do
    listing = Listing.new('London', 1_000_000, 'Wonderful one-bedroom apartment with falling ceilings')

    expect(listing.name).to eq 'London'
    expect(listing.price).to eq 1_000_000
    expect(listing.description).to eq 'Wonderful one-bedroom apartment with falling ceilings'
  end
end
