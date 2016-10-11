FactoryGirl.define do
  factory :note do
    content { Faker::Lorem.paragraph }
    project
  end
end
