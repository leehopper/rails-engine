# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Movies::StarWars.character }

    trait :with_items do
      transient do
        item_count { 3 }
      end

      after(:create) do |merchant, evaluator|
        create_list(:item, evaluator.item_count, merchant: merchant)
      end
    end
  end
end
