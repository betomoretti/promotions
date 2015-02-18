Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :credit_cards, :banks, :conditions
  resources :promotions, except: [:index, :show]
  resources :airlines, only: :index

  patch 'promotions/:id/enable',:to => "promotions#enable"
  patch 'promotions/:id/disable',:to => "promotions#disable"

  # You can have the root of your site routed with "root"
  root 'conditions#index'
end
