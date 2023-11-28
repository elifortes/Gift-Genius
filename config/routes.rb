Rails.application.routes.draw do



  # get 'groups/index'
  # get 'groups/new'
  # get 'groups/show'
  # get 'groups/destroy'
  # get 'groups/edit'
  # get 'groups/update'
  # get 'groups/create'

  devise_for :users
  root to: "pages#home"
resources :myoccasions
  get 'myoccasions/new', to: 'myoccasions#new'

  get 'myoccasions/create', to: 'myoccasions#create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'profiles/show', to: 'profiles#show'
  get "groups/gift", to: "groups#gift"
  get "groups/confirmation", to: "groups#confirmation"
  resources :groups do
    member do


    end
  end
  get "groups/gift", to: "groups#gift"

  get 'questions', to: 'questions#show'

  resources :profiles do
    member do
      get :questionnaire
      post :user_answers
    end
  end

  post 'answers', to: 'answers#create'
  resources :proposals do
    member do
      get :confirmation

  # Defines the root path route ("/")
  # root "posts#index"
    end
  end
end
