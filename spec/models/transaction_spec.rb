require 'rails_helper'

RSpec.describe Transaction do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    context 'presence_of' do
      it { should validate_presence_of(:credit_card_number) }
      it { should validate_presence_of(:credit_card_expiration_date) }
      it { should validate_presence_of(:result) }
    end

    context ':credit_card_number' do
      it { should validate_numericality_of(:credit_card_number).only_integer }
      it { should validate_length_of(:credit_card_number).is_equal_to(16) }
    end
  end
end
