# frozen_string_literal: true

require 'listing'
require 'database_helper'

describe 'Listing' do
  # it 'should have a name, price, description' do
  # end
  before(:each) do
    empty
    add_original_list
  end

  describe '.create' do
    it 'creates a new listing' do
      listing = Listing.create(name: 'London', price: 100, description: 'Wonderful one-bedroom apartment with falling ceilings', date: '2021-06-01', available_from: '2021-07-01', available_to: '2021-08-01', image: '/images/House1.jpeg', host:'host@example.com')

      persisted_data = persisted_data(id: listing.id, table: 'listings')
      expect(listing).to be_a Listing
      expect(listing.id).to eq persisted_data['id']
      expect(listing.name).to eq 'London'
      expect(listing.price).to eq 100
      expect(listing.description).to eq 'Wonderful one-bedroom apartment with falling ceilings'
      # expect(listing.date).to eq ('2021-06-01')
      expect(listing.available_from).to eq '2021-07-01'
      expect(listing.available_to).to eq '2021-08-01'
    end
  end

  describe '.find' do
    it 'returns the requested listing' do
      listing = Listing.create(name: 'London', price: 100, description: 'Wonderful one-bedroom apartment with falling ceilings', date: '2021-06-01', available_from: '2021-07-01', available_to: '2021-08-01', image: '/images/House1.jpeg', host: 'host@example.com')
      persisted_data = persisted_data(id: listing.id, table: 'listings')
      result = Listing.find(id: listing.id)
      expect(result.id).to eq listing.id
    end
  end
end
