class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :display_text
      t.string :tag

      t.timestamps
    end
  end
end
