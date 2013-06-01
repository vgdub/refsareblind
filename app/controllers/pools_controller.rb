class PoolsController < ApplicationController

	def new
	end

	def create
		pool = Pool.create! pool_params
		redirect_to pool_url(pool.slug)
	end

	def show
		@pool = Pool.includes(:pool_type).find_by_slug(params[:slug])
	end

	def index
		@pools = Pool.public
	end

private
	def pool_params
		params.require(:pool).permit(:name, :pool_type_id, :slug)
	end

end
