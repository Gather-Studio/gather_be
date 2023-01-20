class ItemSerializer 
  include JSONAPI::Serializer 

  attributes :name, :style, :status, :clay_body, :height, :width, :memo, :item_glazes
  
  attribute :item_glazes do |item|
    item.item_glazes.map do |glaze|
      {
        glaze: glaze_name(glaze.glaze_id),
        layers: glaze.layers
      }
      end
    end
    
  def self.glaze_name(id)
    glaze = Glaze.find(id)
    glaze.name
  end

end