Rails.application.routes.draw do
  

  devise_for :users
  root to: 'home#index'
  resources :surveys
  # get '/questions/new/:survey_id', to: 'questions#new', as: 'add_question'
  get '/surveys/:survey_id/questions/new', to: 'questions#new', as: 'add_question'
  resources :questions
  get '/questions/:question_id/new_answers', to: 'questions#new_answers', as: 'new_answers'
  match '/questions/:question_id/add_answers', to: 'questions#add_answers', as: 'add_answers', via: :post
  get '/surveys/:survey_id/fill', to: 'filled_surveys#new', as: 'fill_survey'
  resources :filled_surveys , only: [:new, :create]

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
