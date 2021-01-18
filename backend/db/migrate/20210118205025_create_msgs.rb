class CreateMsgs < ActiveRecord::Migration[6.0]
  def change
    create_table :msgs do |t|
      t.string :msg
      t.string :subject
      t.string :email
      t.string :lastname
      t.string :firstname

      t.timestamps
    end
  end
end
