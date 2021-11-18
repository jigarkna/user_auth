class ProfileController < ApplicationController
	before_action :user_logged_in?
	
	def edit_profile
		@user=User.find(session[:user])
		if request.post?
			if @user
				if @user=User.update(user_params)
					UserNotifierMailer.edit_profile_confirmation(@user).deliver
					flash[:notice]="User profile has been edited and updated successfully!"
					redirect_to :account=> :index
				else
					render :action=>"edit_profile"
				end
			end
		end
	end

	def user_logged_in?
		if session[:user].nil?
			flash[:notice]="Please Login to edit profile"
			redirect_to :account=> :login
		end
	end
	
	private
  def user_params
	params.permit(:first_name, :last_name, :dob, :mobile, :email, :hashed_password, :password)
  end
end