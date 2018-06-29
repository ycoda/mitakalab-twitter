FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "abc#{n}"}
    sequence(:email) {|n| "test#{n}@example.com"}
    password "112233"
  end
end
