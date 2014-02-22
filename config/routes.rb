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

  resource :users

  devise_for :users

	namespace :api do
    namespace :v1  do
      devise_for :users, :controllers => {:registrations => 'api/v1/registrations'}

      devise_scope :user do
        patch "user/update_password", :to => "registrations#update_password", :as => "update_password"
      end

      controller :secure do
        get "secure/" => :index
      end

      controller :contact do
        post "contact", :to => "contact#create"
      end

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
