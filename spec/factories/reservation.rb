FactoryBot.define do
  factory :reservation do
    use_application { 'バスケットボール' }
    start_time      { '2020-09-01T12:00:00' }
    end_time        { '2020-09-01T15:00:00' }
    release         { false }
    association :facility
    association :user
    association :team

    trait :release do
      release { true }
    end

    trait :none do
      use_application { '' }
    end
  end
end