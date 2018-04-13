Rails.application.routes.draw do
  root 'posts#index'

  get 'posts/index'
  get '/posts' => 'posts#index'

  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'

  post 'posts/create_comment' => 'posts#create_comment'

  get 'posts/:id' => 'posts#show'

  patch 'posts/:id' => 'posts#update'

  patch 'posts/:id/comment_update' => 'posts#update_comment'

  delete 'posts/delete_post/:id' => 'posts#delete_post'

  delete 'posts/:id/delete_comment/:id' => 'posts#delete_comment'

  patch 'posts/like_post/:id' => 'posts#like_post'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  
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
