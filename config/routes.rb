Rails.application.routes.draw do

  devise_for :users

  resources :chapters do
    resources :carpools
  end

  root to: "main#index"

end
