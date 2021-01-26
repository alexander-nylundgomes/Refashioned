class CreateMiscs < ActiveRecord::Migration[6.0]
  def change
    create_table :miscs do |t|
      t.integer :value
      t.string :name

      t.timestamps
    end
  end
end
