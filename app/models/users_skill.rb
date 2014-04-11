class UsersSkill < ActiveRecord::Base
	belongs_to :user
	has_one :skill

	attr_accessible :user_id, :skill_id
end
