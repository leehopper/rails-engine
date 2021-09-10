# frozen_string_literal: true

class RevenueMerchantSerializer
  include JSONAPI::Serializer

  set_type 'merchant_revenue'
  attributes :revenue
end
