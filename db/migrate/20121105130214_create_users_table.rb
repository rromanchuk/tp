class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
     t.string :stripe_customer_id
    end
    add_index :users, :stripe_customer_id
  end

  def down
  end
end
