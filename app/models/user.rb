class User < ApplicationRecord
  
  validates :first_name,:last_name,:dob,presence: true
  validates :email,presence: true,uniqueness: true
  validates :password,presence: true,confirmation: true,:if => :password_validation_required?
  validates :mobile,presence: true
  attr_accessor :password
  before_save :encrypt_password,:if => :password_validation_required?
  def authenticate(email,string)
    user=User.find_by_email(email)
	if hashed_password ==encrypt(string)
      return user
    end
  end
  def password_validation_required?
    hashed_password.blank? || !password.blank?
  end

  private
  def encrypt_password
    logger.info "________________"
    self.hashed_password=encrypt(password)
  end
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end

end