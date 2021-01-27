class AddDiscountIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :discount_id, :integer
  end
end
