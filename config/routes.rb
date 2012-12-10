PATS67272::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  # Authentication routes
  match 'user/edit' => 'users#edit', :as => :edit_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  resources :sessions
  resources :users
  
  # Generated model routes
  resources :owners do
	resources :notes
  end
  resources :animals
  resources :pets do
	resources :notes
  end
  resources :visits do
	resources :notes    
  end 
  resources :medicines
  resources :procedures
  resources :medicine_costs
  resources :procedure_costs
  resources :animal_medicines
  resources :notes
  
  # Semi-static page routes
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search
  
  # Set the root url
  root :to => 'home#index'
end
