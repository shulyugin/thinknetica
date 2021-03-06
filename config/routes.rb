Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :questions, shallow: true do
    resources :answers
  end

  root to: 'questions#index'
end
