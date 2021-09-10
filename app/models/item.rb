# frozen_string_literal: true

# Item Model
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

  def self.name_query(input)
    where(
      Item.arel_table[:name]
      .lower
      .matches("%#{input.downcase}%")
    )
      .order(:name)
      .first
  end

  def self.min_price_query(min)
    where('unit_price >= ?', min.to_s)
      .order(:name)
      .first
  end

  def self.max_price_query(max)
    where('unit_price <= ?', max.to_s)
      .order(:name)
      .first
  end

  def self.range_price_query(min, max)
    where(unit_price: min..max)
      .order(:name)
      .first
  end

  def revenue
    invoice_items.total_revenue.sum(&:revenue)
  end
end
