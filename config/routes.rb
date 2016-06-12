LOCALES = /en|da/ unless defined? LOCALES

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  ActiveAdmin.routes(self)

  root 'home#index'

  resources :static_pages
  localized do
    resources :polls
    get 'concept' => 'pages#concept', as: 'concept'
    get 'sign_in' => 'pages#sign_in', as: 'sign_in'
  end
end
