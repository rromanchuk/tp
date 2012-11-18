class AddTotalAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount, :decimal, :precision => 8, :scale => 2
    add_column :orders, :total_amount_cents, :integer
    add_column :orders, :status, :string
  end
end
