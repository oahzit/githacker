# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_project do
    user_id 1
    project_id 1
    access 1
    notification_level 1
  end
end
