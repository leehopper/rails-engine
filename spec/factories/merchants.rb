# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Movies::StarWars.character }
  end
end
