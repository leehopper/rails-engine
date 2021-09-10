# frozen_string_literal: true

module Api
  module V1
    # Controller to return revenue json data
    class RevenueController < ApplicationController
      def merchant_index
        merchants = Merchant.top_merchants_by_revenue(quantity_param[:quantity])
        render json: RevenueMerchantsSerializer.new(merchants, is_collection: true)
      end

      def merchant_show
        merchant = Merchant.find(id_param[:id])
        render json: RevenueMerchantSerializer.new(merchant).serializable_hash
      end

      private
      def quantity_param
        params.permit(:quantity)
      end

      def id_param
        params.permit(:id)
      end
    end
  end
end
