Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  resources :courses, only: [:index, :show]
  namespace :instructor do

    # This line is by design: By specifying only: [], we specify that we want to only hook up URLs for [], the empty array, or in other words not to add anything.
    resources :sections, only: [] do
      resources :lessons, only: [:new, :create]
    end

    resources :courses, only: [:new, :create, :show] do
      resources :sections, only: [:new, :create]
    end
  end
end
