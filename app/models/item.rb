class Item < ActiveRecord::Base

  include ActiveMerchant::Shipping
 attr_accessible :quantity, :sku

  belongs_to :order
  
  @shipwire
  SKUS = {:big_roll => 'BigRoll'}


end
