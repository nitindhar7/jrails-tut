ActionController::Routing::Routes.draw do |map|
  # Regular routes:
  map.connect 'store/new', :controller => 'store', :action => 'new'
  map.connect 'store/create', :controller => 'store', :action => 'create'
  map.connect 'store/show/:id', :controller => 'store', :action => 'show'
  map.connect 'store/edit/:id', :controller => 'store', :action => 'edit'
  map.connect 'store/update/:id', :controller => 'store', :action => 'update'
  map.connect 'store/destroy/:id', :controller => 'store', :action => 'destroy'
  map.connect 'store/sort', :controller => 'store', :action => 'sort'

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # Root route
  map.root :controller => "store"

  # See how all your routes lay out with "rake routes"
end
