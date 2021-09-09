require 'rails_helper'

RSpec.describe 'Merchants API' do
  describe 'get all merchants' do
    context 'happy path' do
      it 'returns a variable number of merchants ordered by revenue' do
        merchant_1 = create(:merchant, :with_items, item_count: 1)
        m1_invoice_item = create(:invoice_item, item: merchant_1.items.first, quantity: 10, unit_price: 10)
        create(:transaction, invoice: m1_invoice_item.invoice)

        merchant_2 = create(:merchant, :with_items, item_count: 1)
        m2_invoice_item = create(:invoice_item, item: merchant_2.items.first, quantity: 9, unit_price: 10)
        create(:transaction, invoice: m2_invoice_item.invoice)

        merchant_3 = create(:merchant, :with_items, item_count: 3)
        m3_invoice_item_1 = create(:invoice_item, item: merchant_3.items.first, quantity: 1, unit_price: 10)
        m3_invoice_item_2 = create(:invoice_item, item: merchant_3.items.second, quantity: 1, unit_price: 10)
        m3_invoice_item_3 = create(:invoice_item, item: merchant_3.items.last, quantity: 6, unit_price: 10)
        create(:transaction, invoice: m3_invoice_item_1.invoice)
        create(:transaction, invoice: m3_invoice_item_2.invoice)
        create(:transaction, invoice: m3_invoice_item_3.invoice)

        merchant_4 = create(:merchant, :with_items, item_count: 1)
        m4_invoice_item = create(:invoice_item, item: merchant_4.items.first, quantity: 5, unit_price: 10)
        create(:transaction, invoice: m4_invoice_item.invoice)

        merchant_5 = create(:merchant, :with_items, item_count: 1)
        m5_invoice_item = create(:invoice_item, item: merchant_5.items.first, quantity: 1, unit_price: 10)
        create(:transaction, invoice: m5_invoice_item.invoice)

        get '/api/v1/revenue/merchants?quantity=5'

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(5)

        expected = [merchant_1, merchant_2, merchant_3, merchant_4, merchant_5]

        expected.each_with_index do |merchant, index|
          expect(merchants[index][:id]).to eq(merchant.id.to_s)
          expect(merchants[index][:attributes][:name]).to eq(merchant.name)
        end
      end
    end
  end
end
