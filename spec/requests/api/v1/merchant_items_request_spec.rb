# frozen_string_literal: true

require 'rails_helper'

describe 'Merchant Items API' do
  describe 'get merchant items' do
    context 'happy path' do
      it 'can get items for merchant by merchant id' do
        id = create(:merchant, :with_items).id

        get "/api/v1/merchants/#{id}/items"

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_an(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to eq('item')

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_an(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_an(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_an(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_an(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to eq(id)

          expect(item).to_not have_key(:created_at)
          expect(item).to_not have_key(:updated_at)
        end
      end
    end
  end
end
