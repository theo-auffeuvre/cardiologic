Rails.application.routes.draw do
  devise_for :users

  get "pages/toto", to: "pages#toto", as: "/toto"

  root to: "consultations#new"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :consultations, only: %i[new create show index search_cardio] do
    resources :users, only: %i[new create]
    resources :messages, only: :create
    get :search_cardio, on: :member
    post :send_mail, on: :member
  end

  get "/yo", :to => redirect('/index.html')

  get "/sandwich", to: "consultations#sandwich"
  post "messages/createsandwich", to: "messages#createsandwich"
  get '/myprofile', to: 'users#myprofile'
end
