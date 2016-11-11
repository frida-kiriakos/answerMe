Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users
  
  resources :surveys
  
  get '/surveys/:survey_id/questions/new', to: 'questions#new', as: 'add_question'
  
  resources :questions
    
  get '/surveys/:survey_id/fill', to: 'filled_surveys#new', as: 'fill_survey'
  
  resources :filled_surveys , only: [:new, :create]
  
  resources :answers
  
end
