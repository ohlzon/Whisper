Whisper::Application.routes.draw do
  resources :remote_switches do
    get :on, :on => :member
    get :off, :on => :member
  end
  resources :devices do
    get :writeconfig, :on => :collection
  end
  root :to => 'remote_switches#index'
end
