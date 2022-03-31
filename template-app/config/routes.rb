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
end
