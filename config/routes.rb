Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'
  get 'pages/check_out', to: 'pages#check_out', as: 'check_out'
  get 'projects', to: 'projects#index', as: 'projects'
  post 'projects', to: 'projects#create'
  get 'projects/new', to: 'projects#new', as: 'new_project' 
  get 'projects/:id', to: 'projects#show', as: 'project'
  put 'projects/:id', to: 'projects#update'
  patch 'projects/:id', to: 'projects#update'
  get 'projects/:id/edit', to: 'projects#edit', as: 'edit_project'
  delete 'projects/:id', to: 'projects#destroy', as: 'destroy_project'
  
  post 'options', to: 'options#create'
  get 'options/new', to: 'options#new', as: 'new_option'
  get 'options/:id', to: 'options#show', as: 'option'
  put 'options/:id', to: 'options#update'
  patch 'options/:id', to: 'options#update'
  get 'options/:id/edit', to: 'options#edit', as: 'edit_option'
  delete 'options/:id', to: 'options#destroy', as: 'destroy_option'

  get 'payments/success/:id', to: 'payments#success', as: 'payments_success'
  post "payments/webhook", to: "payments#webhook"
  post 'payments', to: 'payments#support_session', as: 'support_session'
  
  # to handle the routing error that happends during connecting to the Stripe
  match 'payments', to: "application#render_not_found", via: :all
  match 'options', to: "application#render_not_found", via: :all
end
