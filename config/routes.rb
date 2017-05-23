Rails.application.routes.draw do


  namespace :account do
    resources :collections
  end

  namespace :admin do

    resources :jobs do

      member do
        post :hide
        post :publish
      end

    resources :resumes

    end

  end

  devise_for :users

  resources :jobs do
    resources :resumes

    member do
      post :add
      post :remove
    end

  end


  root "welcome#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
