Whisper::Application.routes.draw do
  resources :devices do
    get :on, :on => :member
    get :off, :on => :member
    get :learn, :on => :member
    get :cronalize, :on => :member
  end
  resources :settings
  resources :events
  root :to => 'devices#index'
end
