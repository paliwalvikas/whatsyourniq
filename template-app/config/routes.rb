# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  get '/healthcheck', to: proc { [200, {}, ['Ok']] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  require 'sidekiq/web'
  require 'sidekiq-status/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :bx_block_catalogue do
    get 'search', to: 'products#search'
    get 'regenerate_master_data', to: 'products#regenerate_master_data'
    resources :products do
      collection do
        get :niq_score
        get :smart_search_filters
        delete :delete_old_data
        get :product_smart_search
        get :compare_product
        post :prod_health_preference
        post :change_for_cal
        get :product_calculation
        delete :delete_health_preference
      end
    end
    resources :compare_products
    get 'filter_fav_product', to: 'favourite_products#filter_fav_product'
    resources :favourite_products
    resources :favourite_searches 
    resources :order_items
    resources :orders
  end

  namespace :bx_block_faq_and_contact_us do
    resources :faqs
  end

  namespace :bx_block_add_profile do
    resources :add_profiles
    resources :relations
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
  delete '/destroy_all', to: 'bx_block_catalogue/compare_products#destroy_all'
  delete 'remove_product', to: 'bx_block_catalogue/orders#remove_product'

  scope :add_profiles do
    post "calculate_bmi", to: "bx_block_add_profile/add_profiles#calculate_bmi"
  end
end
