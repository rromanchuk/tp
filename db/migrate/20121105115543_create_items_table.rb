class CreateItemsTable < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.integer :order_id
      t.string :sku
      t.integer :quantity
    end
    add_index :items, :order_id
  end

  def down
    drop_table :items
  end
end
