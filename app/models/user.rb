class User < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_uniqueness_of :email 
  validates_presence_of :password_digest, :first_name, :last_name 

  has_secure_password
  enum role: %w(default admin)

  before_create do
    self.email.downcase!
    self.api_key = SecureRandom.hex if self.admin?
  end
end
