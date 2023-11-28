FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {"test123"}

    trait :customer do
      role {"customer"} 
    end

    trait :delivery_partner do
      role {"delivery_partner"} 
    end
  end
end