class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:user][:email])
		if user.present? && user.try(:authenticate, params[:user][:password])
			session[:user_id] = user.id
			flash[:notice] = "Successfully signed in"
			redirect_to user_account_url
			return
		else
			session[:user_id] = nil
			flash[:error] = "Invalid email address or password"
			redirect_to login_url
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out"
		redirect_to root_url
	end

end
