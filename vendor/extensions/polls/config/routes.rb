Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :polls do
    resources :polls, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :polls, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :polls, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
