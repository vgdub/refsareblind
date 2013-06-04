class NflPicksController < ApplicationController
	before_action :set_pool
	before_action :set_current_entry
	before_action :require_settled_payment

	def new
		if @pool.pool_type == PoolType.where(name: "survival").first
			@available_teams = NflTeam.all - @current_entry.nfl_teams_used
		end
		@matchups = NflMatchup.where(week: CURRENT_NFL_WEEK)
	end

	def create
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
				redirect_to new_pool_user_url(@pool.slug)
			end
		end
	end

	def require_settled_payment
		redirect_to pool_payment_url(@pool.slug) if !@pool.payment_settled?
	end

end
