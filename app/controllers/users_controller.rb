class UsersController < ApplicationController
	before_action :set_user, only: [:account]

	def account
	end

private
	def set_user
		@user = current_user
	end

end
