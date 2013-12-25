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
  match 'projects/:id/team/delete' => 'projects#remove_member', :controller => 'projects', :action => 'remove_member', :via => [:post], :as => 'remove_member'

  resources :users_projects


  get 'help'        => 'help#index'
  get 'help/uses'   => 'help#uses'
  get 'help/docs'   => 'help#docs'


end