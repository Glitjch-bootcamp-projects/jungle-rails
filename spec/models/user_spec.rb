require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    context 'Signing up' do
      it 'should prevent signing up if password and password confirmation do not match' do
        @user = User.new(
          first_name: "bob", 
          last_name: "ross",
          email: "bobross@hotmail.com",
          password: "hello",
          password_confirmation: "helli"
        )
        @user.save
          expect(@user.valid?).to be false
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'should preventing signup of the email is not unique' do
        @user1 = User.new(
          first_name: "bob", 
          last_name: "ross",
          email: "bobross@hotmail.com",
          password: "hello",
          password_confirmation: "hello"
        )
        @user1.save
        
        @user2 = User.new(
          first_name: "gob", 
          last_name: "boss",
          email: "bobross@hotmail.com",
          password: "hello",
          password_confirmation: "hello"
        )
        @user2.save
        
        @user3 = User.new(
          first_name: "sob", 
          last_name: "loss",
          email: "BobROSS@hotMAIL.com",
          password: "hello",
          password_confirmation: "hello"
        )
        @user3.save

        expect(@user2.valid?).to be false
        expect(@user2.errors.full_messages).to include("Email has already been taken")
        expect(@user3.errors.full_messages).to include("Email has already been taken")
      end
      it 'should prevent signing up if email, first name and last name are absent' do
        @user = User.new(
          first_name: nil, 
          last_name: nil,
          email: nil,
          password: "hello",
          password_confirmation: "hello"
        )
        @user.save
          expect(@user.valid?).to be false
      end
      it 'should prevent signing up if password is less than 5 characters' do
        @user = User.new(
          first_name: "bob", 
          last_name: "ross",
          email: "bobross@hotmail.com",
          password: "hell",
          password_confirmation: "hell"
        )
        @user.save
          expect(@user.valid?).to be false
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
    end
  end
  describe '.authenticate_with_credentials' do
    it "should authenticate email and password from login" do
      password = BCrypt::Password.create("hello")
      @user = User.new
        @user.first_name = "bob"
        @user.last_name = "ross"
        @user.email = "bobross@gmail.com"
        @user.password = password
        @user.password_confirmation = "hello"
      
      @user.save
      
      # puts "----0---"
      # puts @user.inspect
      # puts @user.authenticate(@user.password)
      # puts "----0---"      
      
      result = User.authenticate_with_credentials("bobross@gmail.com", password)
      # puts "======2===="
      # puts result.inspect
      # puts "======2===="
      expect(result).to eq(@user)
    end

  end
  
end
