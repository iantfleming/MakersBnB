require 'pg'
require 'bcrypt'

class User

  attr_reader :id, :firstname, :lastname, :email, :encrypted_password

  def initialize(id:, firstname:, lastname:, email:, password:)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @email = email
    @encrypted_password = password
  end

  def self.create(firstname:, lastname:, email:, password:)

    encrypted_password = BCrypt::Password.create(password)

    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("INSERT INTO users (firstname, lastname, email, password) VALUES ('#{firstname}', '#{lastname}', '#{email}', '#{encrypted_password}') RETURNING id, firstname, lastname, email, password;")
    User.new(id: result[0]['id'], firstname: result[0]['firstname'], lastname: result[0]['lastname'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.login(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    user = find(email)
    return nil unless user
    return nil unless user.password == password
    user
  end

  def password
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def self.find(email)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makersbnb_test')
    else
      con = PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("SELECT * FROM users WHERE email = '#{email}'")
    return nil if result.count.zero?
    User.new(id: result[0]['id'], firstname: result[0]['firstname'], lastname: result[0]['lastname'], email: result[0]['email'], password: result[0]['password'])
  end


end