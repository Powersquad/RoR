Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "employees#index"
  resources :employees
  resources :main_menu, only: [:index]
  resources :sessions, only: [:create, :destroy]
  resources :products, :path => "productListing" do
    get :search, on: :collection
  end

  resources :cart, only: [:addItem] do
    get :addItem, on: :collection
  end

  resources :transaction, only: [:product_browsing, :productSearch, :index, :show, :create, :destroy] do
    get :productSearch, on: :collection
    get :product_browsing, on: :collection
  end
  
end
