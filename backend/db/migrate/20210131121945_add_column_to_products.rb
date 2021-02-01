class AddColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :discount_price, :integer
  end
end
