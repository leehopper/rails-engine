# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) { |n| n * 50 }
    unit_price { item.unit_price }
    invoice
    item
  end
end
