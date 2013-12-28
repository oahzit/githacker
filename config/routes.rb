Githacker::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users

	resources :projects do 
		member do
			get 'team'
		end
	end

	match 'projects/:id/team/' => 'projects#add_member', :controller => 'projects', :action => 'add_member', :via => [:post], :as => 'add_member'
	match 'projects/:id/team/:user_id/delete' => 'projects#remove_member', :controller => 'projects', :action => 'remove_member', :via => [:post], :as => 'remove_member'

	resources :users_projects


	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'


end