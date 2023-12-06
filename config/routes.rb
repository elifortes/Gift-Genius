Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users
  root to: "pages#home"
  resources :proposals do
    resources :products
  end
  resources :products do
    member do
      put :sort
    end
  end
  get "myoccasions/new", to: "myoccasions#new"
  get "gifts/create"
  resources :myoccasions do
    get "gift", to: "myoccasions#gift"
    get "confirmation", to: "myoccasions#confirmation"
    resources :gifts
  end
  resources :mycontacts
  resources :gifts
  resources :occasions do
    resources :questions
  end

  resources :proposals do
    resources :products do
      get "confirmation", to: "proposals#confirmation"
    end
  end

  resources :products do
  end

  get "questions/show", to: "questions#show"
  get "groups/gift", to: "groups#gift"
  post "groups/gift", to: "groups#gift"
  get "groups/confirmation", to: "groups#confirmation"
  post "groups/confirmation", to: "groups#confirmation"
  resources :groups do
    get "groups/gift", to: "groups#gift"
    post "groups/gift", to: "groups#gift"
  end
  get "groups/gift", to: "groups#gift"
  get "questions/new", to: "questions#new"

  post "/update_notification", to: "application#update_notification"

  # get "products", to: "products#index"

  resources :questions

  post "recommendations", to: "recommendations#create"
  get "question", to: "questions#show"

  resources :questions do
    member do
      get :questionnaire
      post :user_answers
    end
  end

  post 'update_notification', to: 'pages#update'


  post "answers", to: "answers#create"
  resources :proposals do
    member do
      get :confirmation

      # Defines the root path route ("/")
      # root "posts#index"
    end
  end
end
