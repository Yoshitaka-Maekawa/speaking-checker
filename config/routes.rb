Rails.application.routes.draw do
  namespace :admin do
    root to: "users#index"

    resources :total_results
    resources :recording_results
    resources :questions
    resources :users
  end

  root 'static_pages#top'
  get '/top' => 'static_pages#top'
  get '/help' => 'static_pages#help'
  get '/terms' => 'static_pages#terms'
  get '/privacy' => 'static_pages#privacy'
  get '/inquiry' => 'static_pages#inquiry'
  post '/get_token' => 'static_pages#get_token'

  devise_for :users
  resources :questions, only: %i[show new create]
  resources :recording_results, only: %i[index show create] do
    collection do
      get :narrow_down
    end
  end
  resources :total_results, only: %i[show]
end
