require 'user'
require 'database_helper'

describe 'User' do

  before(:each) do
    empty
  end

  describe '.create' do
    it 'creates a new user' do
      user = User.create(firstname:'Dennis', lastname:'the Menace', email: 'test@example.com', password:'password123')
      persisted_data = persisted_data(id: user.id, table: 'users')
      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.firstname).to eq 'Dennis'
      expect(user.lastname).to eq 'the Menace'
      expect(user.email).to eq 'test@example.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
  
      User.create(firstname:'Dennis', lastname:'the Menace', email: 'test@example.com', password:'password123')
    end
  end

  describe '.login' do
    it 'authenticates the user email and password' do
      user = User.create(firstname:'Dennis', lastname:'the Menace', email: 'test@example.com', password:'password123')
      authenticated_user = User.login(email: 'test@example.com', password:'password123')
      expect(authenticated_user.id).to eq user.id
    end
  end      

end