Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  resources :containers do
    member do
      patch :mark_as_shipped
      get :pick
      post :add_item
      delete :remove_item
      get :items
      get :summary
      get :manifest
    end
    collection do
      get :choose_for_picking
    end
  end
  resources :inventory_items
  resources :item_subcategories, except: :index do
    collection do
      get "picker"
    end
  end
  resources :item_categories
  resources :settings, only: [ :index, :edit, :update ]
  resources :users, except: :destroy, constraints: { id: /[0-9]+/ } do
    collection do
      post "login"
      delete "logout"
    end
  end
end
