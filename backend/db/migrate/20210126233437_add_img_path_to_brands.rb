class AddImgPathToBrands < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :img_path, :string
  end
end
