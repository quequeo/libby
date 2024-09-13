FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    role { :member }

    trait :librarian do
      role { :librarian }
    end
  end
end
