SagepointApi::Application.routes.draw do

  # devise_for  :users,
  #             :controllers => {
  #               :sessions => "sessions"
  #             },
  #             :path => :account,
  #             :path_names => {
  #               :sign_in => :login,
  #               :sign_out => :logout
  #             }

  #devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root :to => 'devise/sessions#new'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  #resource :users

	namespace :api do
    namespace :v1  do
      devise_for :users
    end
  end
	# controller :sessions do
	# 	get 'login' => :new
	# 	post 'login' => :create
	# 	delete 'logout' => :destroy
	# end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

end
