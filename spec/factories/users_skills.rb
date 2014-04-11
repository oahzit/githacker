# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_skill, :class => 'UsersSkills' do
    user_id 1
    skill_id 1
    level 1
  end
end
