class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :value
      t.string :address
      t.string :city
      t.string :email
      t.string :phone
      t.string :firstname
      t.string :lastname
      t.string :postal
      t.string :tracking

      t.timestamps
    end
  end
end
