class ItemGlaze < ApplicationRecord
  belongs_to :item 
  belongs_to :glaze 

  validates_presence_of :layers, :item_id, :glaze_id
end