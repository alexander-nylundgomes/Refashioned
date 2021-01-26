class AddBoughtColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :bougth, :boolean
  end
end
