FactoryGirl.define do
  factory :client do
    name { Faker::Pokemon.name }
  end
end
