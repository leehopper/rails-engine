# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Revenue API' do
  describe 'get top merchants by revenue ' do
    context 'happy path' do
      it 'returns a variable number of merchants ordered by revenue' do
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

        get '/api/v1/revenue/merchants?quantity=5'

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

        expect(merchants.count).to eq(5)

        expected = [merchant1, merchant2, merchant3, merchant4, merchant5]

        expected.each_with_index do |merchant, index|
          expect(merchants[index][:id]).to eq(merchant.id.to_s)
          expect(merchants[index][:attributes][:name]).to eq(merchant.name)
          expect(merchants[index][:attributes][:revenue]).to eq(merchant.revenue)
        end
      end
    end
  end
end
