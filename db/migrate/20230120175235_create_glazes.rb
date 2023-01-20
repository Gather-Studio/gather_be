class CreateGlazes < ActiveRecord::Migration[5.2]
  def change
    create_table :glazes do |t|
      t.string :name
      t.string :brand

      t.timestamps
    end
  end
end
