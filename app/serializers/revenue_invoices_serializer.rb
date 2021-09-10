# frozen_string_literal: true

class RevenueInvoicesSerializer
  include JSONAPI::Serializer

  set_type 'unshipped_order'
  attributes :potential_revenue
end
