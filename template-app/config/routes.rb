# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # devise_for :admin_users, ActiveAdmin::Devise.config
  get '/healthcheck', to: proc { [200, {}, ['Ok']] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :bx_block_catalogue do
    get 'search', to: 'products#search'
    resources :products do
      collection do
        get :niq_score
        get :smart_search_filters
        get :smart_product_serach
        delete :delete_old_data
      end
    end
    resources :favourite_searches
    resources :order_items
    resources :orders
  end

  namespace :account_block do
    resources :accounts
    get 'search', to: 'accounts#search'
  end

  namespace :account_block, default: { format: :json } do
    resources :accounts
    post 'resend_otp', to: '/account_block/accounts/send_otps#create'
  end

  namespace :bx_block_categories do
    resources :categories, only: %i[index]
  end

  namespace :bx_block_search_history do
    resources :total_time_spent_in_apps, only: %i[create show index]
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

  post 'sms_otp', to: 'account_block/accounts/send_otps#create'
  post '/accounts/sms_confirmation', to: 'account_block/accounts/sms_confirmations#create'
end
