# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  # def self.query_by_id(id)
  #   if find_by(id: id).present?
  #     Merchant.find_by(id: id)
  #   else
  #     ErrorDataRecord.new("No merchants found with id: #{id}", "NOT FOUND", 404)
  #   end
  # end
end
