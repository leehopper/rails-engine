# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '#top_merchants_by_revenue' do
      it 'returns a variable number of merchants ranked in order by total revenue' do
        merchant1 = create(:merchant, :with_items, item_count: 1)
        m1_invoice_item = create(:invoice_item, item: merchant1.items.first, quantity: 10, unit_price: 10)
        create(:transaction, invoice: m1_invoice_item.invoice)

        merchant2 = create(:merchant, :with_items, item_count: 1)
        m2_invoice_item = create(:invoice_item, item: merchant2.items.first, quantity: 9, unit_price: 10)
        create(:transaction, invoice: m2_invoice_item.invoice)

        merchant3 = create(:merchant, :with_items, item_count: 3)
        m3_invoice_item1 = create(:invoice_item, item: merchant3.items.first, quantity: 1, unit_price: 10)
        m3_invoice_item2 = create(:invoice_item, item: merchant3.items.second, quantity: 1, unit_price: 10)
        m3_invoice_item3 = create(:invoice_item, item: merchant3.items.last, quantity: 6, unit_price: 10)
        create(:transaction, invoice: m3_invoice_item1.invoice)
        create(:transaction, invoice: m3_invoice_item2.invoice)
        create(:transaction, invoice: m3_invoice_item3.invoice)

        merchant4 = create(:merchant, :with_items, item_count: 1)
        m4_invoice_item = create(:invoice_item, item: merchant4.items.first, quantity: 5, unit_price: 10)
        create(:transaction, invoice: m4_invoice_item.invoice)

        merchant5 = create(:merchant, :with_items, item_count: 1)
        m5_invoice_item = create(:invoice_item, item: merchant5.items.first, quantity: 1, unit_price: 10)
        create(:transaction, invoice: m5_invoice_item.invoice)

        not_expected_merchant = create(:merchant, :with_items, item_count: 1)
        ne_invoice_item = create(:invoice_item, item: not_expected_merchant.items.first, quantity: 1, unit_price: 5)
        create(:transaction, invoice: ne_invoice_item.invoice)

        expect(Merchant.top_merchants_by_revenue(5)).to eq([merchant1, merchant2, merchant3, merchant4, merchant5])

        expect(Merchant.top_merchants_by_revenue(5)).to_not include(not_expected_merchant)
      end
    end

    describe '#name_query' do
      it 'returns merchants by name' do
        create(:merchant, name: 'Frodo')
        m2 = create(:merchant, name: 'Bill')
        m1 = create(:merchant, name: 'Bilbo')
        create(:merchant, name: 'Merry')
        create(:merchant, name: 'Pippin')
        m3 = create(:merchant, name: 'James Billie')

        expect(Merchant.name_query('bil')).to eq([m1, m2, m3])
      end
    end
  end

  describe 'instance methods' do
    describe '.revenue' do
      it 'returns the revenue for a merchant' do
        merchant = create(:merchant, :with_items, item_count: 2)
        invoice_item1 = create(:invoice_item, item: merchant.items.first, quantity: 10, unit_price: 10)
        invoice_item2 = create(:invoice_item, item: merchant.items.second, quantity: 5, unit_price: 5)
        create(:transaction, invoice: invoice_item1.invoice)
        create(:transaction, invoice: invoice_item2.invoice)

        expect(merchant.revenue).to eq(125.0)
      end
    end
  end
end
