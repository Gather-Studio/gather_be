class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :type, :status, :clay_body, :glazes, :height, :width, :memo, :user

end