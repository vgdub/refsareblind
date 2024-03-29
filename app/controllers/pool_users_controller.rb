class PoolUsersController < ApplicationController
	before_action :set_pool, only: [:new, :edit]
	before_action :set_current_entry
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
			redirect_to new_entry_url(@pool.slug)
		end

	end

	def edit
	end

	def approve_entry
		entry = PoolUser.find(params[:entry_id])
		entry.update_attributes(approved: true) if current_user.is_admin_of_pool?(entry.pool_id)
		render nothing: true
	end

	def remove_approval
		entry = PoolUser.find(params[:entry_id])
		entry.update_attributes(approved: false) if current_user.is_admin_of_pool?(entry.pool_id)
		render nothing: true
	end

private
	def set_pool
		@pool = Pool.includes(:pool_type).find_by_slug(params[:slug])
	end

	def set_current_entry
		if !current_user
			flash[:notice] = "You need to be signed in to access that resource"
			redirect_to login_url
			return
		else
			@current_entry = PoolUser.where(user_id: current_user.id, pool_id: @pool.id).first
			if !@current_entry
				flash[:notice] = "It looks like you are not a member of the league you are trying to access, enter the access code to join this league"
				redirect_to new_entry_url(@pool.slug)
			end
		end
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
