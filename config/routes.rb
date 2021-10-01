Rails.application.routes.draw do

  devise_for :users
  resources :profiles
  resources :messages
  resources :carpool_passengers do
    member do
      put :approve
      put :decline
    end
  end
  resources :chapters do
    resources :carpools do
      member do
        get :join
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users
      resources :profiles
      resources :messages
      resources :carpool_passengers do
        member do
          put :approve
          put :decline
        end
      end
      resources :chapters do
        resources :carpools do
          member do
            get :join
          end
        end
      end
    end
  end

  get 'author', to: 'resumes#index'

  root to: "main#index"

end
