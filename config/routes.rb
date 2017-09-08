Rails.application.routes.draw do
     
  
  
  resources :admin_notifications
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :payments, only: [:new, :create, :edit, :update, :destroy]

  resources :notifications, only: [:new, :create, :edit, :update, :destroy, :mynotifications ]
  
  resources :listings do 
  	resources :specks, only: [:new, :create, :edit, :update, :destroy]

  	resources :availabilities, only: [:new, :create, :edit, :update, :destroy] do

  		resources :reservations, only: [:new, :create, :edit, :update, :destroy ] do

        resources :reviews, only: [:new, :create, :edit, :update, :destroy ]

        member do
            get :approvereservation
            # get :markasbilled
            # get :markaspaid 
            # get :markasonhold            
        end

      end

  	end
  	
  end

  root "listings#index"

  match '/mynotifications', to: "notifications#mynotifications", via: :get
  match '/mylistings', to: "listings#mylistings", via: :get
  match '/myreservations', to: "listings#myreservations", via: :get

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

