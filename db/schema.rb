# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121206203759) do

  create_table "items", :force => true do |t|
    t.integer "order_id"
    t.string  "sku"
    t.integer "quantity"
  end

  add_index "items", ["order_id"], :name => "index_items_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_id"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.decimal  "total_amount",            :precision => 8, :scale => 2
    t.integer  "total_amount_cents"
    t.string   "status"
    t.string   "stripe_transaction_id"
    t.string   "sku"
    t.integer  "quantity"
    t.string   "shipwire_transaction_id"
  end

  add_index "orders", ["stripe_customer_id"], :name => "index_orders_on_stripe_customer_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "stripe_customer_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "name"
    t.string   "provider"
    t.integer  "uid",                    :limit => 8,                 :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "phone"
    t.string   "last_four"
  end

  add_index "users", ["stripe_customer_id"], :name => "index_users_on_stripe_customer_id"

end
