class Glaze < ApplicationRecord
  has_many :item_glazes
  has_many :items, through: :item_glazes 

  validates_presence_of :name, :brand
end