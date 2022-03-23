BxBlockFollowers::Engine.routes.draw do
  resources :follows, :only => [:index, :show, :create, :destroy]
end
