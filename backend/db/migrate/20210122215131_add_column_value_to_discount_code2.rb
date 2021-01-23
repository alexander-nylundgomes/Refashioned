class AddColumnValueToDiscountCode2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :discount_codes, :required_amount, :required_value
  end
end
