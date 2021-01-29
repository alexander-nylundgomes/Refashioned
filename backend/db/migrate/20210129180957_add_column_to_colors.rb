class AddColumnToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :color, :string
  end
end
