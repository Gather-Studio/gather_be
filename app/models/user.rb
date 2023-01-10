class User < ApplicationRecord
  has_many :items 
  validates_uniqueness_of :email 
  validates_presence_of :password_digest, :first_name, :last_name 

  has_secure_password 
end
