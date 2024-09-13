FactoryBot.define do
  factory :borrowing do
    user
    book
    due_date { Faker::Date.forward(days: 14) }
    returned { false }
  end
end
