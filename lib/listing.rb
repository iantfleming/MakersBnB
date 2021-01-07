require 'pg'

class Listing
  attr_reader :id, :name, :price, :description, :image

  def initialize(id:, name:, price:, description:, image:)
    @id = id
    @name = name
    @price = price
    @description = description
    @image = image
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end

    result = con.exec('SELECT * FROM listings')
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'], image: listing['image'])
    end
  end

  def self.create(name:, price:, description:, image:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("INSERT INTO listings (name, price, description, image) VALUES ('#{name}', '#{price}', '#{description}', '#{image}') RETURNING id, name, price, description, image;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], image: result[0]['image'])

  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("SELECT * FROM listings WHERE id = #{id}")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], image: result[0]['image'])
  end

end
