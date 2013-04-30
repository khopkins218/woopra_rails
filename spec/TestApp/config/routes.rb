TestApp::Application.routes.draw do
  resources :application

  root to: "application#index"
end
