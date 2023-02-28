Rails.application.routes.draw do
  root 'chat_room#index'
  get 'login',to:'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  
  mount ActionCable.server, to: '/cable'
end
