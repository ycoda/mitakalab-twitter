FactoryBot.define do
  factory :tweet do
    sequence(:title) {|n| "aiueo#{n}"}
    sequence(:content) {|n| "some_coment#{n}"}
  end
end
