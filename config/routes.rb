Rails.application.routes.draw do
  resources :activity_logs
  resources :assistants
  resources :babies do
    resources :activity_logs, only: [:index]
  end
  resources :activities, only: [:show, :create, :update]
end
