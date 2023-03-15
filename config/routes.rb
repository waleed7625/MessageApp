Rails.application.routes.draw do
  root 'chat_room#index'
  get 'login',to:'sessions#new'
  post 'login', to: 'sessions#create'
  get 'signup',to:'sessions#user_new'
  post 'signup', to: 'sessions#user_create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  
  mount ActionCable.server, at: '/cable'
end
