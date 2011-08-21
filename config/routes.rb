Whisper::Application.routes.draw do
  root :to => 'remote_switches#index'
  resources :remote_switches
end
