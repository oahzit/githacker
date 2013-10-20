# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    path "MyString"
    tagline "MyString"
    description "MyText"
    creator_id 1
    public false
  end
end
