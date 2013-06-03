class PoolUsersController < ApplicationController
	before_action :set_pool, only: [:new]
	before_action :check_user_eligible_to_join, only: [:new]

	def new
	end

	def create
		@pool = Pool.find params[:pool_id]
		check_user_eligible_to_join()

		if params[:access_code] == @pool.access_code
			PoolUser.create(user_id: current_user.id, pool_id: @pool.id)
			flash[:notice] = "You have successfully joined the pool #{@pool}"
			redirect_to pool_url(@pool.slug)
		else
			flash[:error] = "The access code that you entered is invalid"
			render :new
		end

	end

private
	def set_pool
		@pool = Pool.includes(:pool_type).find_by_slug(params[:slug])
	end

	def check_user_eligible_to_join
		if !current_user
			flash[:notice] = "Create an account on refsareblind.com in order to join the pool #{@pool.name}"
			redirect_to login_url
		elsif current_user && current_user.has_entry_in_pool?(@pool.id)
			flash[:notice] = "You already have an entry in the pool #{@pool}"
			redirect_to pool_url(@pool.slug)
		end
	end

end
