Rails.application.routes.draw do


  namespace :admin do
    resources :jobs do
      member do
        post :hide
        post :publish
      end
    end
  end

  devise_for :users

  resources :jobs do
    resources :resumes
  end


  root "welcome#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
