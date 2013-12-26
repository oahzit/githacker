# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_group do
    access 1
    group_id 1
    user_id 1
    notification_level 1
    name "MyString"
     ""
    inherit false
  end
end
