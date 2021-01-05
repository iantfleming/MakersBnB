require 'pg'

class Listing
  attr_reader :id, :name, :price, :description

  def initialize(id:, name:, price:, description:)
    @id = id
    @name = name
    @price = price
    @description = description
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end

    result = con.exec('SELECT * FROM listings')
    result.map do |listing|
      # Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'])
      rented_rooms = { :id => listing['id'], :name => listing['name'], :price => listing['price'], :description => listing['description'] }
    end
  end
end
