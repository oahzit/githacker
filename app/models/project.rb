class Project < ActiveRecord::Base
	belongs_to :user
	belongs_to :repository

	def last_activity_to_text
	end

end
