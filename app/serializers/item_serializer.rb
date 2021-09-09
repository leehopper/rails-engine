class ItemSerializer
  include JSONAPI::Serializer

  set_type :item
  attributes :name, :description, :unit_price
  belongs_to :merchant
end
