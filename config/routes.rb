Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
                    :path => '', :path_names => {:sign_in => 'sign_in', :sign_out => 'sign_out'}
  root 'home#protocall_test'
  
  get 'home' => 'home#index'
  
  get 'profile' => 'profiles#new'
  post 'profile' => 'profiles#create'
  get 'profile/edit' => 'profiles#edit'
  post 'profile/edit' => 'profiles#update'
  
  get 'dormsurvey' => 'dorm_surveys#new'
  post 'dormsurvey' => 'dorm_surveys#create'
  get 'dormsurvey/edit' => 'dorm_surveys#edit'
  post 'dormsurvey/edit' => 'dorm_surveys#update'
  
  get 'survey' => 'surveys#new'
  post 'survey' => 'surveys#create'
  get 'survey/edit' => 'surveys#edit'
  post 'survey/edit' => 'surveys#update'
  
  get 'match' => 'matches#show'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end