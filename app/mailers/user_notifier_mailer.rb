class UserNotifierMailer < ApplicationMailer
 
  default from: "PageAdmin@gmail.com"
  def mailer(user)
    puts user.email
    @user = user
    mail(:to => (user.email), :subject => "Account Created!")
  end
  def random_password_send(user,password)
    @user = user
    @password = password
    mail(:to => (user.email), :subject => "Your Temp Password is here")
  end
  def reset_password_confirmation(user)
    @user = user
    mail(:to => (user.email), :subject => "Your password has been reset!")
  end
  
  def edit_profile_confirmation(user)
	puts"================EDITED==============="
	puts user.email
    @user = user
    mail(:to => (user.email), :subject => "Your profile has been edited and updated!")
  end
end
