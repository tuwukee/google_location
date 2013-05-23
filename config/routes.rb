GoogleApp::Application.routes.draw do
  devise_for :users
  resources :users

  match '/auth/:provider/callback' => 'authentications#create'

  root :to => "static_pages#home"
end
