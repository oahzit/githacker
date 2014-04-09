Githacker::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users do
		resources :projects
		resources :activity
		resources :groups 
	end

	resources :projects

	resources :users_projects
	resources :users_groups

	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'


end