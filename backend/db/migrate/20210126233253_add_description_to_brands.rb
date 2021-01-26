class AddDescriptionToBrands < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :description, :string
  end
end
