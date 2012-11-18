class OrdersController < ActionController::Base

  respond_to :json
  def create
    @user = User.find_or_create_by_stripe_customer_id(params[:stripe_customer_id])

    @order = Order.new(:name => params[:name], :address1 => params[:address1], :city => params[:city], :state => params[:state], :zip => params[:zip], :country => params[:country])
    @order.save!
    @order.items.create!(:sku => params[:sku], :quantity => params[:quantity])


    @user.orders << @order
    puts @user.inspect
    respond_with @user
  end
end