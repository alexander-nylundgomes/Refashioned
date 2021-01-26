class RenameColumnCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :cat_name, :name
  end
end
