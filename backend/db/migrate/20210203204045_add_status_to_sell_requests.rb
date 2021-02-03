class AddStatusToSellRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :sell_requests, :status, :string
  end
end
