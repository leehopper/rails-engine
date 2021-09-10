# frozen_string_literal: true

Rails.application.routes.draw do
  get '/api/v1/revenue/merchants', to: 'api/v1/revenue#merchant_index'
  get '/api/v1/revenue/merchants/:id', to: 'api/v1/revenue#merchant_show'
  get '/api/v1/revenue/unshipped', to: 'api/v1/revenue#invoice_index'
  get '/api/v1/revenue/items', to: 'api/v1/revenue#item_index'

  get '/api/v1/items/find', to: 'api/v1/search#item_show'
  get '/api/v1/merchants/find_all', to: 'api/v1/search#merchant_index'
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        resources :items, controller: 'merchant_items'
      end
    end
  end
end
