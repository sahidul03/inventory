Rails.application.routes.draw do
  # devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_for :users, controllers: {sessions: "sessions"}
  # You can have the root of your site routed with "root"
  root 'users#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
    resources :users
    resources :admins do
      collection do
        get "edit_permission/:id", action: 'edit_permission', as: :edit_permission
        post "active"
      end
    end
  resources :admin_permissions
  resources :theme_customizations do
    collection do
      get 'edit_theme'
    end
  end
  resources :user_informations do
    collection do
      post 'profile_picture_change'
      post 'cropped_profile_picture_save'
    end
  end

  resources :food_categories
  resources :food_sub_categories
  resources :items do
    collection do
      get "add_to_card/:id", action: 'add_to_card', as: :add_to_card
      get "remove_from_card/:id", action: 'remove_from_card', as: :remove_from_card
      get "quantity_decrease/:id", action: 'quantity_decrease', as: :quantity_decrease
      get "order_place"
    end
  end
  resources :sub_items
  resources :customer_orders
  resources :ordered_items
  resources :product_colors
  resources :product_types
  resources :parties
  resources :buyers
  resources :bank_accounts
  resources :bank_balance_entries do
    collection do
      get 'monthly_and_yearly_report'
      get 'monthly_and_yearly_report_search'
      get 'monthly_and_yearly_report_download'
      get 'date_to_date_report'
      get 'date_to_date_report_search'
      get 'date_to_date_report_download'
    end
  end
  resources :bank_balance_outs do
    collection do
      get 'monthly_and_yearly_report'
      get 'monthly_and_yearly_report_search'
      get 'monthly_and_yearly_report_download'
      get 'date_to_date_report'
      get 'date_to_date_report_search'
      get 'date_to_date_report_download'
    end
  end

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
  #     # Directs /admin/products/* to Inventory::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
