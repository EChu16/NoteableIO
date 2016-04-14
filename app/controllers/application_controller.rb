class ApplicationController < ActionController::Base

	protect_from_forgery

	private

	def require_user!
		unless current_user
			flash[:error] = "You need to sign in before continuing"
			session[:after_signin_url] = request.original_url
			redirect_to sign_up_path 
		end
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
