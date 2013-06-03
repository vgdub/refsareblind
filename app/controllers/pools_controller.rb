class PoolsController < ApplicationController
	before_action :require_user, only: [:new, :create, :show]
	before_action :set_pool, only: [:show, :pool_payment, :post_pool_payment, :admin_dashboard]
	before_action :require_settled_payment, only: [:show, :join_pool]

	def show
	end

	def index
		@pools = Pool.public
	end

	def new
	end

	def create
		pool = Pool.new
		pool.name = params[:pool][:name]
		pool.pool_type_id = params[:pool][:pool_type_id]
		pool.owner = current_user.id
		if pool.save
			PoolUser.create! user_id: current_user.id, pool_id: pool.id, role: "owner"
			flash[:notice] = "Your pool has successfully been created"
			redirect_to pool_payment_url(pool.slug)
		else
			flash[:error] = "There was an error creating your pool"
			redirect_to new_pool_url
		end
	end

	def pool_payment
		if @pool.payment_settled?
			flash[:error] = "This pool has already been paid for"
			redirect_to pool_url(@pool.slug)
		end
	end

	def post_pool_payment
		begin
			customer = Stripe::Customer.create card: params[:stripeToken], description: current_user.email
		rescue Exception => e
			raise e.inspect
		end

		begin
			charge = Stripe::Charge.create(
				amount: 4000,
				currency: "usd",
				customer: customer.id
				)
		rescue Stripe::CardError => e
			raise e.inspect
		end

		current_user.update_attributes(stripe_customer_id: customer.id)
		pool = Pool.find(params[:pool_id])
		pool.update_attributes(payment_settled: true)
		flash[:notice] = "Your charge has been approved, a receipt will be emailed to you shortly. Welcome to Refs Are Blind"
		redirect_to pool_url(pool.slug)
	end

	def admin_dashboard
	end

private
	def pool_params
		params.require(:pool).permit(:name, :pool_type_id, :slug)
	end

	def set_pool
		@pool = Pool.includes(:pool_type).find_by_slug(params[:slug])
	end

	def require_settled_payment
		redirect_to pool_payment_url(@pool.slug) if !@pool.payment_settled?
	end

end
