require 'sidekiq/web'
PttfoodServer::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      
      resources :categories, :only => [:index]do
        collection do 
          get 'area'
        end
        member do
          get 'subcagtegory'
        end
      end

      resources :articles,:only => [:index, :show] 

    end
  end


end
