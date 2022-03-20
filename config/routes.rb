Rails.application.routes.draw do
  root to: 'dashboard#show'

  get 'auth/:provider/callback', to: 'oauth_callback#create', as: :oauth_callback
  get 'sign_in', to: 'sessions#new', as: :sign_in
  delete 'sign_out', to: 'sessions#destroy', as: :sign_out

  get 'dashboard', to: 'dashboard#show', as: :dashboard

  resources :products, only: [:index, :show, :new, :create] do
    resources :goals, only: [:index, :new, :create], module: :product

    get 'backlog', to: 'product_backlogs#show', as: :backlog
  end

  resources :teams, only: [:index, :new, :create]

  resources :product_backlog_items, only: [:new, :create]

  resources :requirements do
    resources :acceptance_criteria
  end
end
