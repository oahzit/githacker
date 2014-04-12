Githacker::Application.routes.draw do
	root :to => "home#index"
	devise_for :users, :controllers => {:registrations => "registrations"}
	resources :users do
		resources :groups 
		resources :users_projects do 
			member do
				post :add_member  
			end
		end

	end

	resources :projects do
		resources :issues
		resources :notes
		resources :discussions
		resources :settings
		resources :features
	end

	resources :comments
	match 'users/:user_id/issues/all' => 'issues#display', :controller => 'issues', :action => 'display', :via => [:get], :as => 'all_issues'
	match 'issues/:id/up_vote/' => 'issues#up_vote', :controller => 'issues', :action => 'up_vote', :via => [:get], :as => 'up_vote_issue'
	match 'issues/:id/down_vote/' => 'issues#down_vote', :controller => 'issues', :action => 'down_vote', :via => [:get], :as => 'down_vote_issue'

	resources :users_groups
	resources :users_skills


	get 'features' => 'features#index'
	get 'resources' => 'resources#index'
	get 'support' => 'support#index'
	get 'support/docs' => 'support#docs'

end