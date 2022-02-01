Rails.application.routes.draw do
  resources :products, only: [:show] do
    get 'backlog', to: 'product_backlogs#show', as: :backlog
  end
end
