class Item < ApplicationRecord
  belongs_to :user
  has_many :item_glazes, dependent: :destroy
  has_many :glazes, through: :item_glazes 

  validates_presence_of :name, :status
  
  enum status: {"Built" => 0, "Trimmed" => 1, "Bisque Fired" => 2, "Glazed" => 3, "Complete" => 4}

  scope :filter_by_status, -> (status) { where status: status.to_i }

  scope :filter_by_glaze, -> (glaze) { joins(:glazes, :item_glazes).where(glazes: {name: glaze}).uniq}

  # # def self.filter_by_glaze(glaze)
  #     find_by_sql("SELECT * FROM
  #     (SELECT items.name, items.style, items.id, items.status, items.clay_body, items.width, items.height, items.memo, items.clay_body, STRING_AGG(glazes.name || ' x' || item_glazes.layers, ', ') AS glaze_list 
  #     FROM items
  #     INNER JOIN item_glazes
  #     ON items.id = item_glazes.item_id
  #     INNER JOIN glazes 
  #     ON item_glazes.glaze_id = glazes.id 
  #     GROUP BY items.id) AS query
  #     WHERE glaze_list LIKE ('%#{glaze}%');")
  # end

#   SELECT * from items
# INNER JOIN item_glazes
# ON items.id = item_glazes.item_id
# INNER JOIN glazes 
# ON item_glazes.glaze_id = glazes.id
# WHERE glazes.name = '%#{glaze}%';


end
