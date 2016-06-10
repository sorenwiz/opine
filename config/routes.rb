Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'

  resources :polls
  resources :static_pages
  get 'sign_in' => 'static_pages#sign_in'
end
