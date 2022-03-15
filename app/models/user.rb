class User < ActiveRecord::Base
  
  # gives our User model authentication methods via bcrypt
  has_secure_password
  validates :password, confirmation: true 
  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :email, presence: true

  private
  def self.authenticate_with_credentials(email, password)
    if user = User.find_by_email(email.strip.downcase)&.authenticate(password)
      return user
    else
      return nil
    end
  end

end
