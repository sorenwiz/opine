LOCALES = /en|da/ unless defined? LOCALES

Rails.application.routes.draw do
  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  get "/" => redirect("/home")
  #resources :static_pages

  post 'vote/:id', to: 'votes#vote', as: :poll_vote

  get 'sign_in' => 'pages#sign_in', as: 'sign_in'

=begin
    get 'concept' => 'pages#concept', as: 'concept'

    get 'about-us' => 'pages#about_us', as: 'about_us'
    post 'about-us' => 'contact_us#create'
  end
=end

end
