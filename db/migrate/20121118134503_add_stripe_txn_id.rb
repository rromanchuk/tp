class AddStripeTxnId < ActiveRecord::Migration
  def change
    add_column :orders, :stripe_transaction_id, :string
  end
end
