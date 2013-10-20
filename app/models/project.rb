class Project < ActiveRecord::Base
	belongs_to :user
	belongs_to :repository

	attr_accessible :name, :path, :tagline, :description, :creator_id, :public

	def last_activity_to_text
	end

end
