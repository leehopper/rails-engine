
module Api
  module V1
    # Controller to return revenue json data
    class RevenueController < ApplicationController
      def top_merchants
        merchants = Merchant.top_merchants_by_revenue(quantity_param[:quantity])
        render json: RevenueMerchantsSerializer.new(merchants, is_collection: true)
      end

      private
      def quantity_param
        params.permit(:quantity)
      end
    end
  end
end
