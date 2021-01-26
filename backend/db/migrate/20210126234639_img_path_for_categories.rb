class ImgPathForCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :img_path, :string
  end
end
