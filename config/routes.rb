Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'
  get 'projects', to: 'projects#index', as: 'projects'
  post 'projects', to: 'projects#create'
  get 'projects/new', to: 'projects#new', as: 'new_project' 
  get 'projects/:id', to: 'projects#show', as: 'project'
  put 'projects/:id', to: 'projects#update'
  patch 'projects/:id', to: 'projects#update'
  get 'projects/:id/edit', to: 'projects#edit', as: 'edit_project'
  delete 'projects/:id', to: 'projects#destroy', as: 'destroy_project'
  
  # resources :rewards
  get 'options', to: 'options#index', as: 'options'
  post 'options', to: 'options#create'
  get 'options/new', to: 'options#new', as: 'new_option'
  get 'options/:id', to: 'options#show', as: 'option'
  get 'options/:id/edit', to: 'options#edit', as: 'edit_option'
  put 'options/:id', to: 'options#update'
  patch 'options/:id', to: 'options#update'
  delete 'options/:id', to: 'options#destroy', as: 'destroy_option'
end
