Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect("/profiles")

  devise_for :users

  # views
  authenticate :user do
    resources :profiles, only: [:index]
  end
end
