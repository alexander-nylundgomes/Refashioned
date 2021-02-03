class AddReadToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :msgs, :read, :boolean
  end
end
