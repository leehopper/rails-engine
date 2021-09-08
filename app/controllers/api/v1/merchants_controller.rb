# frozen_string_literal: true

module Api
  module V1
    # Controller to return merchant json data
    class MerchantsController < ApplicationController
      def index
        merchants = MerchantFacade.get_merchants(page_params[:page], page_params[:per_page])
        render json: MerchantSerializer.format_merchants(merchants)
      end

      def show
        merchant = Merchant.find(id_param[:id])
        render json: MerchantSerializer.format_merchant(merchant)
      end

      private

      def page_params
        params.permit(:page, :per_page)
      end

      def id_param
        params.permit(:id)
      end
    end
  end
end
