class AddLastFourColumn < ActiveRecord::Migration
  def change
    add_column :users, :last_four, :string
  end
end
