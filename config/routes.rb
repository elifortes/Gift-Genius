Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users
  root to: "pages#home"
  get "myoccasions/new", to: "myoccasions#new"
  get "gifts/create"
  resources :myoccasions do
    get "gift", to: "myoccasions#gift"
    get "confirmation", to: "myoccasions#confirmation"
    resources :gifts
  end
  resources :occasions do
    resources :questions
  end
  resources :proposals

  resources :products do
    member do
      patch :move_image
    end
  end
  resources :gifts
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

  post "answers", to: "answers#create"
  resources :proposals do
    member do
      get :confirmation

      # Defines the root path route ("/")
      # root "posts#index"
    end
  end
end
