Whisper::Application.routes.draw do
  resources :devices do
    get :on, :on => :member
    get :off, :on => :member
    get :learn, :on => :member
    get :writeconfig, :on => :collection
  end
  resources :settings
  root :to => 'devices#index'
end
