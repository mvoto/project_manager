FactoryGirl.define do
  factory :project do
    name { Faker::StarWars.character }
    state Project::STATES.first
    conclusion_date { Time.zone.now + 6.months }
    client
  end
end
