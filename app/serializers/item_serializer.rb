class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :style, :status, :clay_body, :height, :width, :memo

end