# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    first_name { Faker::Movies::HarryPotter.character }
    last_name { Faker::Movies::HarryPotter.spell }
  end
end
