# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    describe '#total_unshipped_revenue' do
      it 'returns the total revenue for unshipped invoices' do
        i1 = create(:invoice, :with_transactions, status: 'pending')
        i2 = create(:invoice, :with_transactions, status: 'pending')
        i3 = create(:invoice, :with_transactions, status: 'pending')
        i4 = create(:invoice, :with_transactions, status: 'pending')
        i5 = create(:invoice, :with_transactions, status: 'pending')
        i6 = create(:invoice, :with_transactions)

        create(:invoice_item, quantity: 10, unit_price: 5, invoice: i1)
        create(:invoice_item, quantity: 5, unit_price: 5, invoice: i2)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        create(:invoice_item, quantity: 1, unit_price: 1, invoice: i4)
        create(:invoice_item, quantity: 15, unit_price: 10, invoice: i5)
        create(:invoice_item, quantity: 100, unit_price: 1000, invoice: i6)

        expect(Invoice.total_unshipped_revenue(3)).to eq(300)
      end
    end
    describe '#unshipped_revenue' do
      it 'returns array of unshipped invoices with revenue attribute' do
        i1 = create(:invoice, :with_transactions, status: 'pending')
        i2 = create(:invoice, :with_transactions, status: 'pending')
        i3 = create(:invoice, :with_transactions, status: 'pending')
        i4 = create(:invoice, :with_transactions, status: 'pending')
        i5 = create(:invoice, :with_transactions, status: 'pending')
        i6 = create(:invoice, :with_transactions)

        create(:invoice_item, quantity: 10, unit_price: 5, invoice: i1)
        create(:invoice_item, quantity: 5, unit_price: 5, invoice: i2)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        create(:invoice_item, quantity: 1, unit_price: 1, invoice: i4)
        create(:invoice_item, quantity: 15, unit_price: 10, invoice: i5)
        create(:invoice_item, quantity: 100, unit_price: 1000, invoice: i6)

        expect(Invoice.unshipped_revenue(3).first.revenue).to eq(150)
        expect(Invoice.unshipped_revenue(3).second.revenue).to eq(100)
        expect(Invoice.unshipped_revenue(3).third.revenue).to eq(50)
      end
    end
  end
end
