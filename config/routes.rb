Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'projects', to: 'projects#index', as: 'projects'
  get 'projects/:id', to: 'projects#show', as: 'project'
end
