# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.top_merchants_by_revenue(count)
    joins(items: { invoice_items: { invoice: :transactions } })
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .where(transactions: { result: :success })
      .order(revenue: :desc)
      .limit(count)
  end

  def self.name_query(input)
    where(
    Merchant.arel_table[:name]
    .lower
    .matches("%#{input.downcase}%")
    )
    .order(:name)
  end

  def revenue
    invoice_items.total_revenue.sum(&:revenue)
  end

  # def self.query_by_id(id)
  #   if find_by(id: id).present?
  #     Merchant.find_by(id: id)
  #   else
  #     ErrorDataRecord.new("No merchants found with id: #{id}", "NOT FOUND", 404)
  #   end
  # end
end
