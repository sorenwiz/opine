Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :vote_options do
    resources :vote_options, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :vote_options, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :vote_options, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
