class AddUserColumns < ActiveRecord::Migration
  def change
    ## Database authenticatable
      add_column :users, :email, :string , :null => false, :default => ""
      add_column :users, :encrypted_password, :string, :null => false, :default => ""
      add_column :users, :name, :string
      add_column :users, :provider, :string
      add_column :users, :uid, :bigint, :null => false

      ## Recoverable
      add_column   :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime

      ## Rememberable
      add_column :users, :remember_created_at, :datetime

      ## Trackable
      add_column :users, :sign_in_count, :integer, :default => 0
      add_column :users, :current_sign_in_at, :datetime
      add_column :users, :last_sign_in_at, :datetime
      add_column :users, :current_sign_in_ip, :string
      add_column :users, :last_sign_in_ip, :string

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token
      add_column :users, :authentication_token, :string
  end

end
