class UsersController < ApplicationController
	before_action :require_user, only: [:account]

	def account
	end

end
