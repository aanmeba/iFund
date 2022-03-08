Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :rewards do

    get 'rewards/:id/edit', to: 'rewards#edit', as: 'edit_reward'
    put 'reward/:id', to: 'rewards#update'
    patch 'reward/:id', to: 'rewards#update'
  end

  
  root to: 'pages#home'
  get 'projects', to: 'projects#index', as: 'projects'
  post 'projects', to: 'projects#create'
  get 'projects/new', to: 'projects#new', as: 'new_project' 
  get 'projects/:id', to: 'projects#show', as: 'project'
  put 'projects/:id', to: 'projects#update'
  patch 'projects/:id', to: 'projects#update'
  get 'projects/:id/edit', to: 'projects#edit', as: 'edit_project'
  delete 'projects/:id', to: 'projects#destroy', as: 'destroy_project'
  
end
