# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    context 'presence_of' do
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:unit_price) }
    end

    context 'numericality_of' do
      it { should validate_numericality_of(:quantity).only_integer }
      it { should validate_numericality_of(:unit_price) }
    end
  end
end
