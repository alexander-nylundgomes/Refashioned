class CreateOrderdProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :orderd_products do |t|
      t.integer :product_id
      t.integer :order_id

      t.timestamps
    end
  end
end
