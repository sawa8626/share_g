FactoryBot.define do
  factory :team do
    name          { 'Ballers' }
    activity     { 'バスケットボール' }
    twitter_url   { Faker::Internet.url }
    facebook_url  { Faker::Internet.url }
    instagram_url { Faker::Internet.url }
    content       { '社会人バスケットボールサークルです！' }
  end
end