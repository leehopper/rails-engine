# frozen_string_literal: true

module Api
  module V1
    # Controller to return search query json data
    class SearchController < ApplicationController
      def item_show
        item = SearchFacade.get_item(item_params)
        if item.instance_of?(Item)
          render json: ItemSerializer.new(item)
        else
          render json: ErrorDataRecordSerializer.new(item).serialized_json
        end
      end

      def merchant_index
        merchants = Merchant.name_query(merchant_param[:name])
        render json: MerchantSerializer.new(merchants, is_collection: true)
      end

      private

      def item_params
        params.permit(:name, :min_price, :max_price)
      end

      def merchant_param
        params.permit(:name)
      end
    end
  end
end
