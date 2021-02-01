class RenameProductsColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :discount_price, :old_price
  end
end
