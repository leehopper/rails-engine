# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    context 'presence_of' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:unit_price) }
    end

    context 'numericality_of' do
      it { should validate_numericality_of(:unit_price) }
    end
  end

  describe 'class methods' do
    describe '#by_revenue' do
      it 'returns items ranked by revenue' do
        i1 = create(:invoice, :with_transactions)
        i2 = create(:invoice, :with_transactions)
        i3 = create(:invoice, :with_transactions)
        i4 = create(:invoice, :with_transactions)
        i5 = create(:invoice, :with_transactions)

        create(:invoice_item, quantity: 10, unit_price: 5, invoice: i1)
        create(:invoice_item, quantity: 5, unit_price: 5, invoice: i2)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        create(:invoice_item, quantity: 1, unit_price: 1, invoice: i4)
        create(:invoice_item, quantity: 15, unit_price: 10, invoice: i5)

        expect(Item.by_revenue(4).first.revenue).to eq(150)
        expect(Item.by_revenue(4).second.revenue).to eq(100)
        expect(Item.by_revenue(4).third.revenue).to eq(50)
        expect(Item.by_revenue(4).last.revenue).to eq(25)
      end
    end

    describe '#name_query' do
      it 'returns single record and first alphabetically' do
        create(:item, name: 'Bill')
        create(:item, name: 'Frodo')
        create(:item, name: 'Merry')
        item = create(:item, name: 'Bilbo')
        create(:item, name: 'Pippin')

        expect(Item.name_query('bil')).to eq(item)
      end
    end

    describe '#min_price_query' do
      it 'returns single record and first alphabetically' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        item = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        expect(Item.min_price_query(25)).to eq(item)
      end
    end

    describe '#max_price_query' do
      it 'returns single record and first alphabetically' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        item = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        expect(Item.max_price_query(40)).to eq(item)
      end
    end

    describe 'range_price_query' do
      it 'returns single record and first alphabetically' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        item = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        expect(Item.range_price_query(20, 50)).to eq(item)
      end
    end
  end
end
