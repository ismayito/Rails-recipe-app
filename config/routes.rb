Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "foods#index"

  # Defines the application routes of the rails-recipe-app 
   resources :foods, only: [:index,:create,:new, :destroy]
   resources :recipes, only: [:index, :show,:update,:destroy ,:new ,:create] do
    member do
      patch 'toggle_public'
    end
  end
  
   resources  :recipe_foods, only:[:new,:destroy,:create,:edit,:update]
   
   get 'public_recipes', to: 'recipes#public_recipes'
   get  'general_shopping_list', to: 'recipes#general_shopping_list'
end
