class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :style
      t.integer :status
      t.string :clay_body
      t.string :glazes
      t.float :height
      t.float :width
      t.string :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
