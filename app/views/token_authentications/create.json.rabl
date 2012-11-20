object @user
attributes :id, :stripe_customer_id, :uid, :email, :created_at, :authentication_token

child :orders do
  extends "orders/show"
end