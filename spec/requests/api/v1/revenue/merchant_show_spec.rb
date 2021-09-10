# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Revenue API' do
  describe 'get merchant with total revenue attribute' do
    context 'happy path' do
      it 'returns a merchant by id with a revenue attribute' do
        merchant = create(:merchant, :with_items, item_count: 1)
        invoice_item = create(:invoice_item, item: merchant.items.first, quantity: 10, unit_price: 10)
        create(:transaction, invoice: invoice_item.invoice)

        get "/api/v1/revenue/merchants/#{merchant.id}"

        json = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

        expect(json[:id]).to eq(merchant.id.to_s)
        expect(json[:attributes][:revenue]).to eq(merchant.revenue)
      end
    end
  end
end
