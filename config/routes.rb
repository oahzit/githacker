Githacker::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
  resources :projects

  get 'help'        => 'help#index'
  get 'help/uses'   => 'help#uses'
  get 'help/docs'   => 'help#docs'


end