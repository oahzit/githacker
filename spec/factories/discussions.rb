# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discussion do
    subject "MyString"
    body "MyString"
    type 1
    archived false
    author_id 1
    vote_count 1
    status 1
  end
end
