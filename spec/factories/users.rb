# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Hopkins'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    factory :user_with_game do
      after(:create) { |user| FactoryGirl.create(:game, user: user) }
    end
  end
end
