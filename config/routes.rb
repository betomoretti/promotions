Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :credit_cards, :banks, :conditions
  resources :promotions, except: [:index, :show]
  resources :coefficients, except: [:index, :show]
  resources :airlines, only: :index

  namespace :api do
    namespace :v1 do
      get 'promotions_app/airlines_credit_cards_banks_data'
    end
  end

  get '/logout' => 'application#logout'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  patch 'promotions/:id/enable',:to => "promotions#enable"
  patch 'promotions/:id/disable',:to => "promotions#disable"
  post 'promotions/:id/clone',:to => "promotions#clone"

  patch 'coefficients/:id/enable',:to => "coefficients#enable"
  patch 'coefficients/:id/disable',:to => "coefficients#disable"
  post 'coefficients/:id/clone',:to => "coefficients#clone"

  # You can have the root of your site routed with "root"
  root 'conditions#index'
end
