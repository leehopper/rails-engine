# frozen_string_literal: true

class RevenueMerchantsSerializer
  include JSONAPI::Serializer

  set_type 'merchant_name_revenue'
  attributes :name, :revenue
end
