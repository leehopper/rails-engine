module Api
  module V1
    # Controller to return items data for a specific merchant
    class MerchantItemsController < ApplicationController
      def index
        merchant = Merchant.find_by(id: id_param[:merchant_id])
        render json: ItemSerializer.new(merchant.items, is_collection: true).serializable_hash
      end

      private
      def id_param
        params.permit(:merchant_id)
      end
    end
  end
end
