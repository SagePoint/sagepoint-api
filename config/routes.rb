SagepointApi::Application.routes.draw do

  controller :dashboard do
    get "dashboard" => :index
  end

  devise_for  :users,
              :controllers => {
                :sessions => "sessions"
              },
              :path => :account,
              :path_names => {
                :sign_in => :login,
                :sign_out => :logout
              }

  devise_scope :user do
    root :to => 'dashboard#index'
  end

	namespace :api do
    namespace :v1  do
      resources :skills
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
