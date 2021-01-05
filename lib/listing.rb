# frozen_string_literal: true

class Listing
  attr_reader :name, :price, :description

  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end

  def self.all
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'makersbnb_test')
                 else
                   PG.connect(dbname: 'makersbnb')
                 end

    result = connection.exec('SELECT * FROM listings')
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'])
    p listing
    end
  end
end
