# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    owner_id 1
    notification_level 1
    name "MyString"
    tagline ""
    description ""
    inherit false
    private false
  end
end
