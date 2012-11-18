class OrdersController < ActionController::Base

  respond_to :json
  def create
    @user = User.find_or_create_by_stripe_customer_id(params[:order][:stripe_customer_id])

    @order = Order.new(params[:order])
    @order.save!

    @user.orders << @order
    puts @user.inspect
    respond_with @order
  end

  def inventory
    @stock = Order.fetch_stock_levels
    puts @stock.inspect
    respond_with @stock
  end


end