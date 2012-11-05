class CreateOrdersTable < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :user_id
      t.string :stripe_customer_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phone
      t.string :email
      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :stripe_customer_id
  end

  def down
    drop_table :orders
  end
end
