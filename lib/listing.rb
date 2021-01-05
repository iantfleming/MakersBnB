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
      Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'])
    end
  end

  def self.create(name:, price:, description:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("INSERT INTO listings (name, price, description) VALUES ('#{name}', '#{price}', '#{description}') RETURNING id, name, price, description;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'])
    
  end
end
