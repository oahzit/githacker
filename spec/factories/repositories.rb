# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    name "MyString"
    path "MyString"
    owner_id 1
    tagline "MyString"
    description "MyText"
  end
end
