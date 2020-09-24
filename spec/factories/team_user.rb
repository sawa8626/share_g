FactoryBot.define do
  factory :team_user do
    association :team
    association :user
  end
end