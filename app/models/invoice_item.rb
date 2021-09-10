# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price
  validates_numericality_of :unit_price
  validates :quantity, numericality: { only_integer: true }

  def self.total_revenue
    joins(invoice: :transactions)
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .group(:id)
      .select('sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
  end
end
