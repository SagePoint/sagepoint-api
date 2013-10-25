SagepointPortal::Application.routes.draw do

  devise_for  :users,
              :controllers => {
                :sessions => "sessions"
              },
              :path => :account,
              :path_names => {
                :sign_in => :login,
                :sign_out => :logout
              }


  resource :users

	get 'admin' => 'admin#index'

	controller :secure_test do
		get 'secure' => :index
	end

	# controller :sessions do
	# 	get 'login' => :new
	# 	post 'login' => :create
	# 	delete 'logout' => :destroy
	# end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'secure_test#index'

end
