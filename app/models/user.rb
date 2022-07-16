class User < ApplicationRecord
  has_secure_password

  before_validation :strip_whitespace

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: { minimum: 3}
  validates :password_confirmation, presence: true

  def strip_whitespace
    self.email = self.email.strip unless self.email.nil?
  end

  def self.authenticate_with_credentials email, password

    # from db change to lower case , from input change to lower case and trim
    @user = self.where('lower(email) = ?', email.strip.downcase).first 
    if @user && @user.authenticate(password)
      @user
    else
      return nil
    end


  end


end
