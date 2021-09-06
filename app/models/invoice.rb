# frozen_string_literal: true

class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates_presence_of :status
end
