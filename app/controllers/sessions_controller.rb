class SessionsController < ApplicationController
	def create
		user = User.from_omniauth(env["omniauth.auth"], current_user)
		session[:user_id] = user.id
		redirect_url = session[:after_signin_url] || root_url
		session[:after_signin_url] = nil
		flash[:notice] = "Successfully signed in"
		redirect_to redirect_url
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
