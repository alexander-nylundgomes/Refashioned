class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :product_id

      t.timestamps
    end
  end
end
