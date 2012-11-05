class OrdersController < ActionController::Base

  respond_to :json
  def create
    @order = Order.new(:name => params[:name], :address1 => params[:address1], :address2 => params[:address2], :city => params[:city], :state => params[:state], :country => params[:country])
    puts @order.inspect
    respond_with @order
  end
end