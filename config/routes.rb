Rails.application.routes.draw do
  get 'profile/edit_profile'
  post 'profile/edit_profile'
  get 'password/forget_password'
  post 'password/forget_password'
  get 'password/reset_password'
  post 'password/reset_password'
  get 'account/signup'
  post 'account/signup'
  get 'account/login'
  get 'account/logout'
  post 'account/login'
  get 'home/index'
  patch 'account/login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
