class AddGradeToQuality < ActiveRecord::Migration[6.0]
  def change
    add_column :qualities, :grade, :string
  end
end
