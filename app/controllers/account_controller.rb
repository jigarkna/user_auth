class AccountController < ApplicationController
  
  def signup
    if request.post?
      puts "--------------"
      @user=User.new(user_params)
      puts "--------------"
      if @user.save
        UserNotifierMailer.mailer(@user).deliver
		flash[:notice]="User is created. Please check your mail!"
        redirect_to :action => :login
      else
        render :action => :signup
      end
    end
  end

  def login
    if request.post?
      @user=User.find_by_email(params[:email])
        if @user.authenticate(params[:email],params[:password])
          session[:user]=@user.id
		  flash[:notice]="YOU ARE LOGGED IN"
          redirect_to "/home/index"
        else
		  flash[:notice]="Invalid Creds"
          render :action=> :login
        end

      end
  end

  
  def logout
	session[:user]=nil
	flash[:notice]="You are logged out!"
	redirect_to :action=>:login
  end
  
  private
  def user_params
	params.permit(:first_name, :last_name, :dob, :mobile, :email, :hashed_password, :password)
  end
end
