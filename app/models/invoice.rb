# frozen_string_literal: true

# Invoice Model
class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates_presence_of :status

  def self.by_unshipped_revenue(count)
    joins(:transactions, :invoice_items)
      .where(transactions: { result: 'success' })
      .where.not(status: 'shipped')
      .group(:id)
      .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as potential_revenue')
      .order(potential_revenue: :desc)
      .limit(count)
  end

  def revenue
    invoice_items.total_revenue_unshipped.sum(&:revenue)
  end
end
