GoogleApp::Application.routes.draw do
  devise_for :users
  resources :users

  match '/auth/:provider/callback' => 'authentications#create'

  match '/users/:id/wall_post' => 'users#wall_post', :as => :wall_post

  root :to => "static_pages#home"
end
