Githacker::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users do
		member do
			post :add_skills  
		end

		resources :groups 
		resources :users_groups do
		end
		resources :users_projects do 
			member do
				post :add_member  
				get :team
			end
		end

	end

	resources :projects do
		resources :issues
		resources :notes
		resources :discussions
		resources :features
	end

	resources :comments
	match 'users/:user_id/issues/all' => 'issues#display', :controller => 'issues', :action => 'display', :via => [:get], :as => 'all_issues'
	# Up and down vote discussions
	match 'discussions/:id/up_vote/' => 'discussions#up_vote', :controller => 'discussions', :action => 'up_vote', :via => [:get], :as => 'up_vote_discussion'
	match 'discussions/:id/down_vote/' => 'discussions#down_vote', :controller => 'discussions', :action => 'down_vote', :via => [:get], :as => 'down_vote_discussion'
	# Follow projects
	match 'users/:user_id/projects/:project_id/follow/' => 'users_projects#follow', :controller => 'users_projects', :action => 'follow', :via => [:get], :as => 'follow_project'

	resources :users_groups
	resources :users_skills


	get 'features' => 'features#index'
	get 'resources' => 'resources#index'
	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'

end