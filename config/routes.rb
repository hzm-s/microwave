Rails.application.routes.draw do
  root to: 'dashboard#show'

  get 'dashboard', to: 'dashboard#show', as: :dashboard

  resources :products, only: [:index, :show, :new, :create] do
    resources :goals, only: [:index, :new, :create], module: :product

    get 'backlog', to: 'product_backlogs#show', as: :backlog
  end

  resources :product_backlog_items, only: [:new, :create]

  resources :requirements do
    resources :acceptance_criteria
  end
end
