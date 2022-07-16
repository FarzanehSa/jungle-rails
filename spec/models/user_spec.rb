require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    
    it 'will pass with correct attributes' do
      @user = User.new(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '123', password_confirmation: '123')
      expect(@user).to be_valid
    end

    it 'will fail with blanck password' do
      @user = User.new(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: nil, password_confirmation: '123')
      expect(@user).to_not be_valid
    end

    it 'will fail with blanck password_confirmation' do
      @user = User.new(first_name: 'f-name', last_name: 'l-name', email: 'a@g.com', password: '123', password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'will fail when password_confirmation does not match password  ' do
      @user = User.new(first_name: 'f-name', last_name:'l-name', email: 'a@g.com', password: '123', password_confirmation: '1234')
      expect(@user).to_not be_valid
    end

    it 'will fail with blanck email' do
      @user = User.new(first_name: 'f-name', last_name: 'l-name', email: nil, password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
    end

    it 'will fail with blanck first_name' do
      @user = User.new(first_name: nil, last_name: 'l-name', email: 'a@g.com', password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
    end

    it 'will fail with blanck last_name' do
      @user = User.new(first_name: 'f-name', last_name: nil, email: 'a@g.com', password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
    end

    it 'email is unique and not case sensitive and does not care white space before and after' do
      @user1 = User.create(first_name: 'f-name', last_name: 'l-name', email: 'a@g.com', password: '123', password_confirmation: '123')

      @user2 = User.new(first_name: 'f-name', last_name: 'l-name', email: ' A@g.com', password: '123', password_confirmation: '123')
      expect(@user2).to_not be_valid
    end

    it 'will fail with short password (less than 3)' do
      @user = User.new(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '12', password_confirmation: '12')
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    it 'will return user if user exist' do
      @user = User.create(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '123', password_confirmation: '123')

      @loginUser = User.authenticate_with_credentials 'a@g.com', '123'
      expect(@user).to match @loginUser
    end

    it 'will return nil if user not exist' do
      @user = User.create(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '123', password_confirmation: '123')

      @loginUser = User.authenticate_with_credentials 'b@g.com', '123'
      expect(@loginUser).to be_nil
    end

    it 'will match user with white space around email' do
      @user = User.create(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '123', password_confirmation: '123')

      @loginUser = User.authenticate_with_credentials ' a@g.com ', '123'
      expect(@user).to match @loginUser
    end

    it 'will match user with email case insensitive' do
      @user = User.create(first_name: 'f-name', last_name:'l-name', email:'a@g.com', password: '123', password_confirmation: '123')

      @loginUser = User.authenticate_with_credentials 'A@g.com', '123'
      expect(@user).to match @loginUser
    end
    
  end

end
