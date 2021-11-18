class HomeController < ApplicationController
  before_action :user_logged_in?

  def index
    @user = User.find(session[:user])
  end


  def user_logged_in?
    if session[:user].nil?
      flash[:alert]="First Login!!"
      redirect_to :controller => "account",:action => "login"
    end
  end
end
