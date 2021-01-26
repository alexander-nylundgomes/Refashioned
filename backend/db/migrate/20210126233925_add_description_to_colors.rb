class AddDescriptionToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :description, :string
  end
end
