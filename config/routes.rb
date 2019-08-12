Rails.application.routes.draw do
  root to: 'users#group_index'
  get '/groups', to: 'users#group_index'
  post '/group_index', to: 'users#shuffle_index'
  get '/users', to: 'users#employee_index'
  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users/:id', to: 'users#create_user'
  post '/users/:id', to: 'users#update'
  post '/users/:id', to: 'users#destroy'
end
