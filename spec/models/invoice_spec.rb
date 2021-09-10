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
    describe '#by_unshipped_revenue' do
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

        expect(Invoice.by_unshipped_revenue(3).first.potential_revenue).to eq(150)
        expect(Invoice.by_unshipped_revenue(3).second.potential_revenue).to eq(100)
        expect(Invoice.by_unshipped_revenue(3).third.potential_revenue).to eq(50)
      end
    end
  end

  describe 'instance methods' do
    describe '.revenue' do
      it 'returns an invoices revenue' do
        i = create(:invoice, :with_transactions, status: 'pending')
        create(:invoice_item, quantity: 10, unit_price: 5, invoice: i)

        expect(i.revenue).to eq(50)
      end
    end
  end
end
