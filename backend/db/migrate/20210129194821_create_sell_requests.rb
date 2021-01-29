class CreateSellRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :sell_requests do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :brand
      t.string :condition
      t.string :file_path
      t.string :asking_price

      t.timestamps
    end
  end
end
