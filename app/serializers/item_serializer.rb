# frozen_string_literal: true

class ItemSerializer
  include JSONAPI::Serializer

  set_type :item
  attributes :name, :description, :unit_price, :merchant_id
end
