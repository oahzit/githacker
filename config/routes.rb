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

    match 'issues/:id/up_vote/' => 'issues#up_vote', :controller => 'issues', :action => 'up_vote', :via => [:get], :as => 'up_vote_issue'
    match 'issues/:id/down_vote/' => 'issues#down_vote', :controller => 'issues', :action => 'down_vote', :via => [:get], :as => 'down_vote_issue'

	get 'all_issues' => 'issues#display'

	resources :users_groups
	resources :users_skills

	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'
	get 'resources' => 'resources#index'


end