# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill, :class => 'Skills' do
    name "MyString"
  end
end
