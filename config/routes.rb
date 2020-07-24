Rails.application.routes.draw do
  resources :activity_logs
  resources :assistants
  resources :babies
  resources :activities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
