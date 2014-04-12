class ProjectsGroup < ActiveRecord::Base
	attr_accessible :project_id, :group_id

	belongs_to :project
	belongs_to :group

end
