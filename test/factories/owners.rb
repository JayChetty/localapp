# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :owner do
    email "test@example.com"
    password 'asdfasdf'
  end
end
