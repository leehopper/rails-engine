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

      def invoice_index
        invoices = Invoice.by_unshipped_revenue(quantity_param[:quantity])
        render json: RevenueInvoicesSerializer.new(invoices, is_collection: true)
      end

      def item_index
        if quantity_param[:quantity].present?
          items = Item.by_revenue(quantity_param[:quantity])
        else
          items = Item.by_revenue(10)
        end
        render json: RevenueItemSerializer.new(items, is_collection: true)
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
