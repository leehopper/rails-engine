class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price
  validates_numericality_of :unit_price
  validates :quantity, numericality: { only_integer: true }
end
