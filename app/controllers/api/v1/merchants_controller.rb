class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page].present? && params[:per_page].present? && params[:page].to_i > 0
      merchants = Merchant.all.paginate(page: params[:page], per_page: params[:per_page])
    elsif params[:page].present? && params[:page].to_i > 0
      merchants = Merchant.all.paginate(page: params[:page], per_page: 20)
    elsif params[:per_page].present?
      merchants = Merchant.all.paginate(page: 1, per_page: params[:per_page])
    else
      merchants = Merchant.all.paginate(page: 1, per_page: 20)
    end
    render json: MerchantSerializer.format_merchants(merchants)
  end
end
