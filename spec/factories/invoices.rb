# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    status { 'shipped' }
    customer

    trait :with_transactions do
      transient do
        transaction_count { 1 }
      end

      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transaction_count, invoice: invoice)
      end
    end

    trait :with_unsuccessful_transaction do
      transient do
        transaction_count { 1 }
      end

      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transaction_count, invoice: invoice, result: 'failed')
      end
    end
  end
end
