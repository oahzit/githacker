Githacker::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users do
		resources :groups 
			resources :users_projects
	end

	resources :projects do
		resources :issues
		resources :discussions
		resources :settings
	end

	get 'all_issues' => 'issues#display'

	resources :users_groups
	resources :users_skills

	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'
	get 'resources' => 'resources#index'


end