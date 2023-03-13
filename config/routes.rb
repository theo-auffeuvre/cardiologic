Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get "pages/toto", to: "pages#toto", as: "/toto"

  root to: "consultations#new"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :consultations, only: %i[new create show index search_cardio] do
    resources :users, only: %i[new create]
    resources :messages, only: :create
    get "/search_cardio", to: "consultations#search_cardio"
  end

  get "/sandwich", to: "consultations#sandwich"
  post "messages/createsandwich", to: "messages#createsandwich"
  

  
  

  get '/myprofile', to: 'users#myprofile'

  post "/send_mail", to: "consultations#send_mail"

end
