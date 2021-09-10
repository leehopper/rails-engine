require 'rails_helper'

RSpec.describe 'Revenue API' do
  describe 'total revenue of scucessful invoices which have not shipped' do
    context 'happy path' do
      it 'returns a variable number of merchants ordered by revenue' do
        i1 = create(:invoice, :with_transactions, status: 'pending')
        i2 = create(:invoice, :with_transactions, status: 'pending')
        i3 = create(:invoice, :with_transactions, status: 'pending')
        i4 = create(:invoice, :with_transactions, status: 'pending')
        i5 = create(:invoice, :with_transactions, status: 'pending')
        i6 = create(:invoice, :with_transactions)

        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i1)
        create(:invoice_item, quantity: 5, unit_price: 5, invoice: i2)
        create(:invoice_item, quantity: 10, unit_price: 10, invoice: i3)
        create(:invoice_item, quantity: 1, unit_price: 1, invoice: i1)
        create(:invoice_item, quantity: 15, unit_price: 10, invoice: i1)
        create(:invoice_item, quantity: 100, unit_price: 1000, invoice: i6)

        get '/api/v1/revenue/unshipped?quantity=3'

        expect(response).to be_successful

        invoices = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(invoices.count).to eq(3)
      end
    end
  end
end
