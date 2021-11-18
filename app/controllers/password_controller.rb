class PasswordController < ApplicationController
	before_action :user_logged_in?, only: %i[ reset_password]
	
  def forget_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = random_password
        @user.update(:password=>new_password)
		puts "====================NEW PASSWORD============"
		puts new_password
        UserNotifierMailer.random_password_send(@user,new_password).deliver
        flash[:notice] = "A new password has been sent your email"
        redirect_to :controller=> :account,:action=> :login
      else
        flash[:notice]="Invalid Email.Please enter correct email"
        render :action=>"forget_password"
      end
      end
   end

	def random_password
    (0...8).map{65.+(rand(25)).chr}.join
  end
  
  def reset_password
	@user = User.find(session[:user])
	 if request.post?
		puts @user.inspect
		  if @user
			@user.update(:password=>params[:password])
			UserNotifierMailer.reset_password_confirmation(@user).deliver
			puts '-------------resetting the password----------------'
			puts '-----------------------end-------------------------'
			flash[:notice] = "Your password has been reset"
			redirect_to :controller=>:home, :action=>:index
		  else
			render :action=>:reset
		  end
	  end
  end
  
  def user_logged_in?
	if session[:user].nil?
	  flash[:alert]="First Login to access private route.."
	  redirect_to :controller => "account",:action => "login"
  end
  end
end
