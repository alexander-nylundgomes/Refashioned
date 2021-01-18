class RemoveColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :brands, :product_id
  end
end
