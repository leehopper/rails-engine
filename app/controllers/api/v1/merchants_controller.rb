# frozen_string_literal: true

module Api
  module V1
    # Controller to return merchant json data
    class MerchantsController < ApplicationController
      def index
        merchants = MerchantFacade.get_merchants(page_params[:page], page_params[:per_page])
        render json: MerchantSerializer.format_merchants(merchants)
      end

      private

      def page_params
        params.permit(:page, :per_page)
      end
    end
  end
end
