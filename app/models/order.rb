class Order < ActiveRecord::Base

  include ActiveMerchant::Shipping
  
  attr_accessible :email, :name, :address1, :address2, :city, :state, :country, :zip


  has_many :items
  belongs_to :user

  @shipwire
  SKUS = {:big_roll => 'BigRoll'}


  def order
    @shipwire = ActiveMerchant::Fulfillment::ShipwireService.new(:login => "rromanchuk@gmail.com", :password => "***REMOVED***")
    items = [{:sku => 'BigRoll', :quantity => 1}]
    address =  {}
  end

end
