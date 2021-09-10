# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: %i[index show] do
        resources :items, controller: 'merchant_items'
      end
    end
  end

  get '/api/v1/revenue/merchants', to: 'api/v1/revenue#top_merchants'
end
