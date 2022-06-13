Rails.application.routes.draw do
  #devise_for :admin_users, ActiveAdmin::Devise.config
  #devise_for :admin_users, ActiveAdmin::Devise.config
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :bx_block_catalogue do
    resources :products, only: %i[index update]
  end 

  namespace :account_block do 
    resources :accounts 
     get'search', to: 'accounts#search'
  end

  namespace :account_block, default: { format: :json } do
    resources :accounts
    post 'resend_otp', to: '/account_block/accounts/send_otps#create'
  end

  namespace :bx_block_login do 
    resources :logins, only: [:create]
  end


  namespace :bx_block_admin do
    resources :privacy_policies do
      collection do
         get :privacy_policy
      end 
    end
  end

  post "sms_otp", to: "account_block/accounts/send_otps#create"
  post "/accounts/sms_confirmation", to: "account_block/accounts/sms_confirmations#create"

end
