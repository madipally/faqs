FactoryGirl.define do
    factory :subject do
      name { Faker::Name.name }
      description { Faker::Lorem.sentence(5)}
    end
end