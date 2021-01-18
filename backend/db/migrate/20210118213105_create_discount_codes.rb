class CreateDiscountCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :amount

      t.timestamps
    end
  end
end
