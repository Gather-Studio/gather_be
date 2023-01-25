class ItemGlazeSerializer 
  include JSONAPI::Serializer 

  attributes :item_id, :glaze_id, :layers
end