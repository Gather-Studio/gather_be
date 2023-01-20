class RemoveGlazesFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :glazes, :string
  end
end
