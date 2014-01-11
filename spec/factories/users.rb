# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Hopkins'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    factory :user_with_group do
      after(:create) { |user| FactoryGirl.create(:group, user: user) }
    end
  end
end
