Rails.application.routes.draw do
  root "home#index"

  get "/auth/google_oauth2", as: :sign_in_with_google
  get "/auth/google_oauth2/callback" => "callbacks#google"

  get "/auth/facebook", as: :sign_in_with_facebook
  get "/auth/facebook/callback", to: 'callbacks#facebook'


  resources :users do
    resources :mortgage_calculators, as: :mortgage_calculator
    resources :profiles, as: :profile
    resources :bank_accounts
    resources :properties
    resources :loan_accounts
    resources :credit_cards
    resources :expenses
    resources :goals do
      resources :follows, only:[:create, :destroy]
    end
    post "/goals/:id" => "goals#mark", as: :mark
    post :mark_done
  end


  get "/changepassword" => "users#change_password", as: :change_password
  patch "/changepassword" => "users#update_password"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :follows, only:[:index]

  resources :password_resets
end
