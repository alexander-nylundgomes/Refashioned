class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :size
      t.string :desc
      t.integer :color
      t.integer :price
      t.string :name

      t.timestamps
    end
  end
end
