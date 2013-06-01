class RegistrationsController < ApplicationController

	def new
	end

	def create
		user = User.create! user_params
		session[:user_id] = user.id
		flash[:notice] = "Account Successfully Created"
		redirect_to :user_account_url
	end

private
	def user_params
		params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :password_digest)
	end

end
