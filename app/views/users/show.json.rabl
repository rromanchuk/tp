object @user
attributes :id, :stripe_customer_id, :created_at, :authentication_token

child :orders do
  extends "orders/show"
end