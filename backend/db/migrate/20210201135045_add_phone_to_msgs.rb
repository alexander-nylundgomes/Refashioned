class AddPhoneToMsgs < ActiveRecord::Migration[6.0]
  def change
    add_column :msgs, :phone, :string
  end
end
