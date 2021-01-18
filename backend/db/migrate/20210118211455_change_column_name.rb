class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :address, :adress
  end
end
