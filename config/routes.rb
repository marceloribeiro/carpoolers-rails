Rails.application.routes.draw do

  devise_for :users

  resources :chapters
  
  root to: "main#index"

end
