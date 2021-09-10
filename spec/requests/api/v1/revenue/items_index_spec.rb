# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Revenue API' do
  describe 'get top items by revenue ' do
    context 'happy path' do
      it 'returns a variable number of items ordered by revenue' do
        i1 = create(:invoice, :with_transactions)
        i2 = create(:invoice, :with_transactions)
        i3 = create(:invoice, :with_transactions)
        i4 = create(:invoice, :with_transactions)
        i5 = create(:invoice, :with_transactions)

        ii1 = create(:invoice_item, quantity: 10, unit_price: 5, invoice: i1)
        ii2 = create(:invoice_item, quantity: 5, unit_price: 5, invoice: i2)
        ii3 = create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        ii4 = create(:invoice_item, quantity: 1, unit_price: 1, invoice: i4)
        ii5 = create(:invoice_item, quantity: 15, unit_price: 10, invoice: i5)

        get '/api/v1/revenue/items?quantity=4'

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

        expect(items.count).to eq(4)

        expected = [ii5.item, ii3.item, ii1.item, ii2.item]

        expected.each_with_index do |item, index|
          expect(items[index][:id]).to eq(item.id.to_s)
          expect(items[index][:attributes][:name]).to eq(item.name)
          expect(items[index][:attributes][:description]).to eq(item.description)
          expect(items[index][:attributes][:unit_price]).to eq(item.unit_price)
          expect(items[index][:attributes][:revenue]).to eq(item.revenue)
        end
      end

      it 'returns default 10 items ordered by revenue' do
        i1 = create(:invoice, :with_transactions)
        i2 = create(:invoice, :with_transactions)
        i3 = create(:invoice, :with_transactions)
        i4 = create(:invoice, :with_transactions)
        i5 = create(:invoice, :with_transactions)
        i6 = create(:invoice, :with_transactions)
        i7 = create(:invoice, :with_transactions)
        i8 = create(:invoice, :with_transactions)
        i9 = create(:invoice, :with_transactions)
        i10 = create(:invoice, :with_transactions)

        create(:invoice_item, invoice: i1)
        create(:invoice_item, invoice: i2)
        create(:invoice_item, invoice: i3)
        create(:invoice_item, invoice: i4)
        create(:invoice_item, invoice: i5)
        create(:invoice_item, invoice: i6)
        create(:invoice_item, invoice: i7)
        create(:invoice_item, invoice: i8)
        create(:invoice_item, invoice: i9)
        create(:invoice_item, invoice: i10)

        get '/api/v1/revenue/items'

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

        expect(items.count).to eq(10)
      end
    end
  end
end
