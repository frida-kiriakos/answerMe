Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :surveys

  get '/surveys/:survey_id/add_question', to: 'surveys#add_question', as: 'add_question'

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
