class RefactorCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :tag
    add_column :categories, :description, :string
    rename_column :categories, :display_text, :name
  end
end
