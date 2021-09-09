# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Movies::StarWars.vehicle }
    description { Faker::Movies::StarWars.wookie_sentence }
    sequence(:unit_price) { |n| n * 9 }
    merchant
  end
end
