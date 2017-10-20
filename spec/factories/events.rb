FactoryGirl.define do
  factory :event do
    association :user, factory: :user, strategy: :build

    title { Faker::Name.title }
    periodicity { %w[once day week month year].sample }
    start { Faker::Date.forward(5) }
    finish { start + 1.month }
    duration 0.5
    description { Faker::Lorem.sentence }
    social { [true, false].sample }
  end
end
