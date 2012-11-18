object @user
attributes :id, :stripe_customer_id, :created_at

child :orders do
  extends "orders/show"
end