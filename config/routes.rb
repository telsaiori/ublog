Rails.application.routes.draw do

  get 'comments/new'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
    resources :articles do 
      resources :comments
    end

  mount ActionCable.server => '/cable'
end
