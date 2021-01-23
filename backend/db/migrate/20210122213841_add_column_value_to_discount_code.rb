class AddColumnValueToDiscountCode < ActiveRecord::Migration[6.0]
  def change
    add_column :discount_codes, :value_in_percent, :integer
    add_column :discount_codes, :value_in_cash, :integer
    add_column :discount_codes, :value_in_shipping, :boolean
    add_column :discount_codes, :required_amount, :integer

  end
end
