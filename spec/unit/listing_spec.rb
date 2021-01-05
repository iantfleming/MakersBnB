# frozen_string_literal: true

require 'listing'
require 'database_helper'

describe 'Listing' do
  # it 'should have a name, price, description' do   
  # end

  describe '.create' do
    it 'creates a new listing' do
      listing = Listing.create(name:'London', price: 100, description:'Wonderful one-bedroom apartment with falling ceilings')
      persisted_data = persisted_data(id: listing.id, table: 'listings')
      expect(listing).to be_a Listing
      expect(listing.id).to eq persisted_data['id']
      expect(listing.name).to eq 'London'
      expect(listing.price).to eq 100
      expect(listing.description).to eq 'Wonderful one-bedroom apartment with falling ceilings'
    end
  end
end
