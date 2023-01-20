class CreateItemGlazes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_glazes do |t|
      t.references :item, foreign_key: true
      t.references :glaze, foreign_key: true
      t.integer :layers

      t.timestamps
    end
  end
end
