class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :style, :status, :clay_body, :height, :width, :memo, :user_id
  
  attribute :item_glazes do |item|
    item.item_glazes.map do |item_glaze|
      {
      id: item_glaze.id,
      type: "item_glaze",
      attributes: 
      {
        glaze: item_glaze.glaze_id,
        layers: item_glaze.layers
      }
    }
      end
    end
    

end