Rails.application.routes.draw do
  root 'home#index'

  get 'polls' => 'home#show'
end
