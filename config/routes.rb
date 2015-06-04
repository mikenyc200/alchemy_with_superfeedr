Rails.application.routes.draw do

  root :to => 'entries#index'

  resources :entries  do
    member do
      get 'analysis'

    end
    collection do
      get 'filter_by_concepts'
      get 'entries_from_concepts'
    end
  end

  get 'concepts' => "feeds#all_concepts"

  resources :feeds do
    member do
      get 'retrieve'
      post 'subscribe'
      post 'unsubscribe'
      get 'concepts'
    end

    collection do
      get 'filter_by_concepts'
      get 'filter_by_all_concepts'
    end
  end

  mount SuperfeedrEngine::Engine => SuperfeedrEngine::Engine.base_path # Use the same to set path in the engine initialization!


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
