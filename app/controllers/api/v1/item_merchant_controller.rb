# frozen_string_literal: true

module Api
  module V1
    # Controller to return items data for a specific merchant
    class ItemMerchantController < ApplicationController
      def index
        item = Item.find(id_param[:item_id])
        render json: MerchantSerializer.new(item.merchant)
      end

      private
      def id_param
        params.permit(:item_id)
      end
    end
  end
end
