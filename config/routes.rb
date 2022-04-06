Rails.application.routes.draw do
  root 'static_pages#top'
  get '/top' => 'static_pages#top'
  get '/help' => 'static_pages#help'
  get '/terms' => 'static_pages#terms'
  get '/privacy' => 'static_pages#privacy'
  get '/inquiry' => 'static_pages#inquiry'
  post '/get_token' => 'static_pages#get_token'
  resources :questions, only: %i[show create] do
    collection do
      get :original
    end
  end
  resources :recording_results, only: %i[index show create] do
    collection do
      get :narrow_down
    end
  end
  resources :total_results, only: %i[show]
end
