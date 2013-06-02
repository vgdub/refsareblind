class NflPicksController < ApplicationController
	before_action :set_pool
	before_action :require_settled_payment

	def new
	end

private
	def set_pool
		@pool = Pool.includes(:pool_type).find_by_slug(params[:slug])
	end

	def require_settled_payment
		redirect_to pool_payment_url(@pool.slug) if !@pool.payment_settled?
	end

end
