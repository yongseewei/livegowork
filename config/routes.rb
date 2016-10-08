Rails.application.routes.draw do

  root 'home#index'

  post "/jobs/filter" => "jobs#filter"
  # get '/profile' => 'pages#profile'

  get '/explore' => 'pages#explore'

  resources :jobs do
    resources :job_applications  #, only: [:index, :new, :create, :show]
  end
 # The priority is based upon order of creation: first created -> highest priority.
  # get 'home/index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

# devise_for :users

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users, only: [:show, :edit, :update, :destroy]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"


  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :relationships
end 
