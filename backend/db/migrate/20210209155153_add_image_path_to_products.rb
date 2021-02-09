class AddImagePathToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :main_image, :string
  end
end
