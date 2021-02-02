class ChangeColorColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :color, :color_id
  end
end
