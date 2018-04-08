Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  get 'dashboard/index'
  get 'dashboard/new_action'
  post 'dashboard/save_new_action'
  devise_for :users, :controllers => { :sessions => "user_sessions" }
  get 'home/index'

  root 'home#index'

  resources :users
  resources :user_actions
end
