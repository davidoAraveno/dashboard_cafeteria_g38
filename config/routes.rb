Rails.application.routes.draw do
  resources :drinks

  root "drinks#dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
