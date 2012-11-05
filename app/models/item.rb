class Order < ActiveRecord::Base

  include ActiveMerchant::Shipping

  belongs_to :order
  
  @shipwire
  SKUS = {:big_roll => 'BigRoll'}


end
