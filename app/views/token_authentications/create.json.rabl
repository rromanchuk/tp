object @user
attributes :id, :stripe_customer_id, :uid, :email, :created_at, :authentication_token, :name, :address1, :address2, :city, :state, :country, :email, :phone

child :orders do
  extends "orders/show"
end