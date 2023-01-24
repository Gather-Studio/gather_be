class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :style, :status, :clay_body, :height, :width, :memo, :glazes
  
  attribute :glazes do |item|
    item.item_glazes.map do |glaze|
      {
        glaze: glaze.id,
        layers: glaze.layers
      }
      end
    end
    

end