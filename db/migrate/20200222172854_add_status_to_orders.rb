class AddStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :integer, default: 0
    Order.all.where(status: nil).update_all(status: 0)
  end
end
