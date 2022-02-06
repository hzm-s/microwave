Rails.application.routes.draw do
  resources :products, only: [:show] do
    get 'backlog', to: 'product_backlogs#show', as: :backlog
  end

  resources :requirements do
    resources :acceptance_criteria
  end
end
