class Order < ActiveRecord::Base
  include ActiveMerchant::Shipping
  SKUS = {:big_roll => 'BigRoll'}
end
