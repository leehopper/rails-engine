# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    context 'presence_of' do
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:unit_price) }
    end

    context 'numericality_of' do
      it { should validate_numericality_of(:quantity).only_integer }
      it { should validate_numericality_of(:unit_price) }
    end
  end

  describe 'class methods' do
    describe '#total_revenue' do
      it 'returns array of invoice items with revenue attribute' do
        i1 = create(:invoice, :with_transactions)
        i2 = create(:invoice, :with_transactions)
        i3 = create(:invoice, :with_transactions)
        i4 = create(:invoice, :with_unsuccessful_transaction)

        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i1)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i2)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        create(:invoice_item, quantity: 5, unit_price: 5, invoice: i4)

        Invoice.all.total_revenue.each do |ii|
          expect(ii.revenue).to eq(100)
        end
      end
    end
  end
end
