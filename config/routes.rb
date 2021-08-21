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

  root to: "main#index"

end
