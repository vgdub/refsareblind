class PoolsController < ApplicationController
	before_action :require_user, only: [:new, :create, :show]

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
			redirect_to pool_url(pool.slug)
		else
			flash[:error] = "There was an error creating your pool"
			redirect_to new_pool_url
		end
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
