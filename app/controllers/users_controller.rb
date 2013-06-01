class UsersController < ApplicationController
	before_action :set_user, only: [:account]

	def account
	end

private
	def set_user
		@user = current_user
		if !@user.present?
			flash[:notice] = "You need to be signed in to access that resource"
			redirect_to :root
		end
	end

end
