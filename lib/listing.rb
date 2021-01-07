require 'pg'

class Listing
  attr_reader :id, :name, :price, :description, :date, :available_from, :available_to

  def initialize(id:, name:, price:, description:, date:, available_from:, available_to:)
    @id = id
    @name = name
    @price = price
    @description = description
    @date = date
    @available_from = available_from
    @available_to = available_to
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end

    result = con.exec('SELECT * FROM listings')
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'], date: listing['date'], available_from: listing['available_from'], available_to: listing['available_to'])
    end
  end

  def self.create(name:, price:, description:, date:, available_from:, available_to:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("INSERT INTO listings (name, price, description, date, available_from, available_to) VALUES ('#{name}', '#{price}', '#{description}', '#{Time.new.strftime('%d/%m/%Y')}', '#{available_from}', '#{available_to}') RETURNING id, name, price, description, date, available_from, available_to;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], date: result[0]['date'], available_from: result[0]['available_from'], available_to: result[0]['available_to'])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("SELECT * FROM listings WHERE id = #{id}")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], date: result[0]['date'], available_from: result[0]['available_from'], available_to: result[0]['available_to'])
  end
end
