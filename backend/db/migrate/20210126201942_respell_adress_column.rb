class RespellAdressColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :adress, :address
  end
end
