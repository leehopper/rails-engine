# frozen_string_literal: true

module Api
  module V1
    # Controller to return search query json data
    class SearchController < ApplicationController
      def item_show
        item = SearchFacade.get_item(item_params)
        render json: ItemSerializer.new(item)
      end

      private
      def item_params
        params.permit(:name, :min_price, :max_price)
      end
    end
  end
end
