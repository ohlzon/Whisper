Whisper::Application.routes.draw do
  resources :devices do
    get :on, :on => :member
    get :off, :on => :member
    get :writeconfig, :on => :collection
  end
  root :to => 'devices#index'
end
