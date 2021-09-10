# frozen_string_literal: true
require 'rails_helper'

describe 'Merchants API' do
  describe 'get all merchants' do
    context 'happy path' do
      it 'sends a list of merchants with default 20 per page' do
        create_list(:merchant, 25)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(20)

        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)

          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to eq('merchant')

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_an(Hash)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_an(String)

          expect(merchant).to_not have_key(:created_at)
          expect(merchant).to_not have_key(:updated_at)
        end
      end

      it 'sends list of merchants with custom page and per page parameter' do
        create_list(:merchant, 25)

        get '/api/v1/merchants?per_page=15&page=2'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(10)
      end

      it 'sends list of merchants with custom per page and default page' do
        create_list(:merchant, 25)

        get '/api/v1/merchants?per_page=21'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(21)
      end

      it 'sends list of merchants with custom page and default per page' do
        create_list(:merchant, 25)

        get '/api/v1/merchants?page=2'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(5)
      end
    end

    context 'sad path' do
      it 'sends empty array of data for page with no merchants' do
        create_list(:merchant, 25)

        get '/api/v1/merchants?page=5'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(0)
        expect(merchants).to be_an(Array)
      end

      it 'sends merchants with default page 1 for page number less than 1' do
        create_list(:merchant, 25)

        get '/api/v1/merchants?page=0'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(20)
      end
    end
  end

  describe 'get one merchant' do
    context 'happy path' do
      it 'can get one merchant by its id' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response).to be_successful

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant')

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_an(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_an(String)

        expect(merchant).to_not have_key(:created_at)
        expect(merchant).to_not have_key(:updated_at)
      end
    end
  end
end
