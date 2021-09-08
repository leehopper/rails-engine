# frozen_string_literal: true

require 'rails_helper'

describe 'Merchant Items API' do
  describe 'get merchant items' do
    context 'happy path' do
      it 'can get items for merchant by merchant id' do
        id = create(:merchant, :with_items).id

        get "/api/v1/merchants/#{id}/items"

        expect(response).to be_successful
      end
    end
  end
end
