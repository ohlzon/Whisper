Whisper::Application.routes.draw do
  resources :devices do
    get :on, :on => :member
    get :off, :on => :member
    get :learn, :on => :member
  end
  resources :settings
  root :to => 'devices#index'
end
