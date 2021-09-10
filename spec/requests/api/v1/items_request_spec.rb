# frozen_string_literal: true
require 'rails_helper'

describe 'Items API' do
  describe 'get all items' do
    context 'happy path' do
      it 'sends a list of items with default 20 per page' do
        create_list(:item, 25)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(20)

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
        end
      end

      it 'sends list of items with custom page and per page parameter' do
        create_list(:item, 25)

        get '/api/v1/items?per_page=15&page=2'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(10)
      end

      it 'sends list of items with custom per page and default page' do
        create_list(:item, 25)

        get '/api/v1/items?per_page=21'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(21)
      end

      it 'sends list of items with custom page and default per page' do
        create_list(:item, 25)

        get '/api/v1/items?page=2'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(5)
      end
    end

    context 'sad path' do
      it 'sends empty array of data for page with no items' do
        create_list(:item, 25)

        get '/api/v1/items?page=5'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(0)
        expect(items).to be_an(Array)
      end

      it 'sends items with default page 1 for page number less than 1' do
        create_list(:item, 25)

        get '/api/v1/items?page=0'

        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(items.count).to eq(20)
      end
    end
  end

  describe 'get one item' do
    context 'happy path' do
      it 'can get one item by its id' do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

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
      end
    end
  end
end
