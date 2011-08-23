Whisper::Application.routes.draw do
  resources :remote_switches do
    get :on, :on => :member
    get :off, :on => :member
  end
  root :to => 'remote_switches#index'
end