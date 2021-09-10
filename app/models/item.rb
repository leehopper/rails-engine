# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price

  def self.by_revenue(count)
    joins(:invoice_items, :invoices, :transactions)
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .group(:id)
    .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .order(revenue: :desc)
    .limit(count)
  end
end
