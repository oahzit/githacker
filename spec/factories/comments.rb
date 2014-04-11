# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyString"
    thread_id 1
    author_id "MyString"
  end
end
