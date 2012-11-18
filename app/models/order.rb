class Order < ActiveRecord::Base

  include ActiveMerchant::Shipping
  
  attr_accessible :email, :name, :address1, :address2, :city, :state, :country, :zip, :stripe_customer_id, :stripe_transaction_id, :quantity, :sku, :status


  has_many :items
  belongs_to :user

  @shipwire
  SKUS = {:big_roll => 'BigRoll'}


  def order
    @shipwire = ActiveMerchant::Fulfillment::ShipwireService.new(:login => "rromanchuk@gmail.com", :password => "***REMOVED***")
    items = [{:sku => 'BigRoll', :quantity => 1}]
    address =  {}
  end

  def address
    { name: name, 
      address1: address1, 
      address2: address2, 
      city: city, 
      zip: zip, 
      state: state, 
      country: country, 
      phone: phone, email: email }
  end

  def self.fetch_stock_levels
    shipwire = ActiveMerchant::Fulfillment::ShipwireService.new(:login => "rromanchuk@gmail.com", :password => "***REMOVED***")
    shipwire.fetch_stock_levels
  end

end
