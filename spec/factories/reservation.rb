FactoryBot.define do
  factory :reservation do
    use_application { 'バスケットボール' }
    start_time      { '2020-09-01T12:00:00' }
    end_time        { '2020-09-01T15:00:00' }
    release         { 'false' }
    association :facility
    association :user
    association :team
  end
end