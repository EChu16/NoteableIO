class SubscriptionsController < ApplicationController
	def destroy
		@subscription = Subscription.find(params[:id])
		@subscription.delete if @subscription.subscriber_id == current_user.id
		render :text => ""
	end

	def create
		@user = User.where(:email=>params[:email]).first
		if @user
			@subscription = Subscription.new(:user_id => @user.id, :subscriber_id => current_user.id, :type => "email")
			@subscription.save
			render :partial => "shared/subscription", :locals => {:subscription => @subscription}
		else
			render :text => "Could not find specified user"
		end
	end
end
