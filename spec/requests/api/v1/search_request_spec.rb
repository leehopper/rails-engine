require 'rails_helper'

describe 'Search API' do
  describe 'get an item' do
    context 'happy path' do
      it 'returns one item by name ' do
        create(:item, name: 'Bill')
        create(:item, name: 'Frodo')
        create(:item, name: 'Merry')
        i = create(:item, name: 'Bilbo')
        create(:item, name: 'Pippin')

        get '/api/v1/items/find?name=Bil'

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(item).to have_key(:id)
        expect(item[:id]).to eq(i.id.to_s)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to eq(i.name)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to eq(i.description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to eq(i.unit_price)
      end

      it 'returns one item by min price ' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        i = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        get '/api/v1/items/find?min_price=25'

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(item).to have_key(:id)
        expect(item[:id]).to eq(i.id.to_s)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to eq(i.name)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to eq(i.description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to eq(i.unit_price)
      end

      it 'returns one item by max price ' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        i = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        get '/api/v1/items/find?max_price=40'

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(item).to have_key(:id)
        expect(item[:id]).to eq(i.id.to_s)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to eq(i.name)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to eq(i.description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to eq(i.unit_price)
      end

      it 'returns one item by range price ' do
        create(:item, name: 'C', unit_price: 10)
        create(:item, name: 'D', unit_price: 20)
        create(:item, name: 'E', unit_price: 30)
        i = create(:item, name: 'A', unit_price: 40)
        create(:item, name: 'B', unit_price: 50)

        get '/api/v1/items/find?min_price=20&max_price=50'

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(item).to have_key(:id)
        expect(item[:id]).to eq(i.id.to_s)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_an(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to eq(i.name)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to eq(i.description)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to eq(i.unit_price)
      end
    end
  end

  describe 'get merchants' do
    context 'happy path' do
      it 'returns merchants by name' do
        create(:merchant, name: 'Frodo')
        create(:merchant, name: 'Bill')
        create(:merchant, name: 'Bilbo')
        create(:merchant, name: 'Merry')
        create(:merchant, name: 'Pippin')
        create(:merchant, name: 'James Billie')

        get '/api/v1/merchants/find_all?name=bil'

        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

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
    end
  end
end
