Rails.application.routes.draw do
  resources :activities
  resources :assistants
  resources :babies do
    resources :activity_logs, only: [:index]
  end
  resources :activity_logs, only: [:index, :show, :create, :update]
end
