Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'pages#home'
  get 'projects', to: 'projects#index', as: 'projects'
  get 'projects/:id', to: 'projects#show', as: 'project'
  get 'projects/new', to: 'projects#new', as: 'new_project' 
end
