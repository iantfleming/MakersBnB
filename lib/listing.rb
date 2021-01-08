# frozen_string_literal: true

require 'pg'

class Listing
  attr_reader :id, :name, :price, :description, :date, :available_from, :available_to, :image, :host

  def initialize(id:, name:, price:, description:, date:, available_from:, available_to:, image:, host:)
    @id = id
    @name = name
    @price = price
    @description = description
    @date = date
    @available_from = available_from
    @available_to = available_to
    @image = image
    @host = host
  end

  def self.all
    con = if ENV['ENVIRONMENT'] == 'test'
            PG.connect(dbname: 'makersbnb_test')
          else
            PG.connect(dbname: 'makersbnb')
          end

    result = con.exec('SELECT * FROM listings')
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'], price: listing['price'], description: listing['description'], date: listing['date'], available_from: listing['available_from'], available_to: listing['available_to'], image: listing['image'], host: listing['host'])
    end
  end

  def self.create(name:, price:, description:, date:, available_from:, available_to:, image:, host:)
    con = if ENV['ENVIRONMENT'] == 'test'
            PG.connect(dbname: 'makersbnb_test')
          else
            PG.connect(dbname: 'makersbnb')
          end
    result = con.exec("INSERT INTO listings (name, price, description, date, available_from, available_to, image, host) VALUES ('#{name}', '#{price}', '#{description}', '#{Time.new.strftime('%d/%m/%Y')}', '#{available_from}', '#{available_to}', '#{image}', '#{host}') RETURNING id, name, price, description, date, available_from, available_to, image, host;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], date: result[0]['date'], available_from: result[0]['available_from'], available_to: result[0]['available_to'], image: result[0]['image'], host: result[0]['host'])
  end

  def self.find(id:)
    con = if ENV['ENVIRONMENT'] == 'test'
            PG.connect(dbname: 'makersbnb_test')
          else
            PG.connect(dbname: 'makersbnb')
          end
    result = con.exec("SELECT * FROM listings WHERE id = #{id}")
    return nil if result.count.zero?
    Listing.new(id: result[0]['id'], name: result[0]['name'], price: result[0]['price'].to_i, description: result[0]['description'], date: result[0]['date'], available_from: result[0]['available_from'], available_to: result[0]['available_to'], image: result[0]['image'], host: result[0]['host'])
  end
end
