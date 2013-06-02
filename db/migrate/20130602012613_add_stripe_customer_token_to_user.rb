class AddStripeCustomerTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :stripe_customer_id, :string
  	add_column :pools, :payment_settled, :boolean
  end
end
