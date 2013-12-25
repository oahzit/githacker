class Project < ActiveRecord::Base
	belongs_to :user
	belongs_to :repository

	has_many :users_projects
    has_many :users, foreign_key: "user_id", :through => :users_projects

	attr_accessible :name, :path, :tagline, :description, :creator_id, :public

	def last_activity_to_text
	end

	def creator
		User.find(creator_id)
	end

end
