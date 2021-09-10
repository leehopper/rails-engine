# frozen_string_literal: true

class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates_presence_of :status

  def self.total_revenue
    joins(:transactions, :invoice_items)
      .where(transactions: { result: 'success' }, status: 'shipped')
      .group(:id)
      .select('sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
  end

  def self.total_unshipped_revenue(count)
    unshipped_revenue(count).sum do |invoice|
      invoice.revenue
    end
  end

  def self.unshipped_revenue(count)
    joins(:transactions, :invoice_items)
    .where(transactions: { result: 'success' })
    .where.not(status: 'shipped')
    .group(:id)
    .select('sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .order(revenue: :desc)
    .limit(count)
  end
end
