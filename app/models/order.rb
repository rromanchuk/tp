class Order < ActiveRecord::Base

  include ActiveMerchant::Shipping
  
  attr_accessible :email, :name, :address1, :address2, :city, :state, :country, :zip, :stripe_customer_id, :stripe_transaction_id, :quantity, :sku, :status, :total_amount_cents


  has_many :items
  belongs_to :user

  @shipwire
  SKUS = {:big_roll => 'BigRoll'}

  def fulfill!
    @shipwire = ActiveMerchant::Fulfillment::ShipwireService.new()
    items = [{:sku => 'BigRoll', :quantity => 1}]
    begin
      response = @shipwire.fulfill(stripe_transaction_id, address, items)
      self.shipwire_transaction_id = response.transaction_id
      save
      response
    rescue Exception => e
      logger.error e.message
      raise e
    end
  end

  def address
    { name: name, 
      address1: address1, 
      address2: address2, 
      city: city, 
      zip: zip, 
      state: state, 
      country: country, 
      phone: phone, 
      email: email }
  end

  def self.fetch_stock_levels
    shipwire = ActiveMerchant::Fulfillment::ShipwireService.new()
    shipwire.fetch_stock_levels
  end

end
