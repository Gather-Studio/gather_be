class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :style, :status, :clay_body, :glazes, :height, :width, :memo

end