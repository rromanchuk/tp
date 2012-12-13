class OrdersController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => :create
  respond_to :json
  
  def create
    @user = current_user

    @order = Order.new(params[:order])
    @order.status = "COMPLETE"
    @order.save!

    @user.orders << @order
    @user.save

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