class UpdateOrdersTable < ActiveRecord::Migration
  def change
    add_column :orders, :sku, :string
    add_column :orders, :quantity, :integer

  end
end
