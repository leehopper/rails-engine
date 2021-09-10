# frozen_string_literal: true

module Api
  module V1
    # Controller to return item json data
    class ItemsController < ApplicationController
      def index
        items = ItemFacade.get_items(page_params[:page], page_params[:per_page])
        render json: ItemSerializer.new(items, is_collection: true)
      end

      def show
        item = Item.find(id_param[:id])
        render json: ItemSerializer.new(item).serializable_hash
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
