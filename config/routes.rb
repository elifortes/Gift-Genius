Rails.application.routes.draw do

  get 'profiles/show'

  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/show'
  # get 'groups/destroy'
  # get 'groups/edit'
  # get 'groups/update'
  # get 'groups/create'

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :groups do
    get "gift", to: "groups#gift"
  end

  resources :proposals

  # Defines the root path route ("/")
  # root "posts#index"
end
