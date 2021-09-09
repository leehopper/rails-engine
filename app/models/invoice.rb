# frozen_string_literal: true

class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates_presence_of :status

  def self.total_revenue
    joins(:transactions, :invoice_items)
    .where(transactions: {result: 'success'}, status: 'shipped')
    .group(:id)
    .select('sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
  end
end
