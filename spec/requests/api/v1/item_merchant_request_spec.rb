# frozen_string_literal: true

require 'rails_helper'

describe 'Item Merchant API' do
  describe 'get item merchant' do
    context 'happy path' do
      it 'can get merchant for item by item id' do
        item = create(:item)

        get "/api/v1/items/#{item.id}/merchant"

        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)
      end
    end
  end
end
