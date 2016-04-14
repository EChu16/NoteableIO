class UsersController < ApplicationController
  def settings
  	@user = current_user
  end

  def update
  	@user = current_user
  	number = params[:phone_number] 
  	User.update(@user.id, phone_number: number)
  	redirect_to root, flash: { :notice => "updated your account!" } 
  end
end
