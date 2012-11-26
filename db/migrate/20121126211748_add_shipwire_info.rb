class AddShipwireInfo < ActiveRecord::Migration
  def change
    add_column :orders, :shipwire_transaction_id, :string
  end
end
