FactoryBot.define do
  factory :game do
    name "hello"
    association :user
  end
end
