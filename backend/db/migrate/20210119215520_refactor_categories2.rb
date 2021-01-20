class RefactorCategories2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :name, :cat_name
  end
end
