class User < ActiveRecord::Base
  has_many :orders
  attr_accessible :stripe_customer_id
end
