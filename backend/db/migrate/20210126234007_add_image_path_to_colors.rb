class AddImagePathToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :img_path, :string
  end
end
