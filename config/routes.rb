Rails.application.routes.draw do
  root to: 'dashboard#show'

  resources :products, only: [:index, :create] do
    get 'backlog', to: 'product_backlogs#show', as: :backlog
  end

  resources :product_backlog_items, only: [:new, :create]

  resources :requirements do
    resources :acceptance_criteria
  end
end
