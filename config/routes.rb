Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :credit_cards, :banks, :conditions
  resources :promotions, except: [:index, :show]
  resources :airlines, only: :index
  
  resources :promotions do
    patch :enable
    patch :disable
  end
  # You can have the root of your site routed with "root"
  root 'conditions#index'
end
