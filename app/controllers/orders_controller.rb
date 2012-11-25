class OrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  def create
    @user = User.find_or_create_by_stripe_customer_id(params[:order][:stripe_customer_id])

    @order = Order.new(params[:order])
    @order.status = "COMPLETE"
    @order.save!

    @user.orders << @order
    puts @user.inspect
    @order.fulfill!
    respond_with @order
  end

  def index

    @orders = Order.all
    respond_to do |format|
      format.html 
    end
  end

  def inventory
    @stock = Order.fetch_stock_levels
    puts @stock.inspect
  end


end