class Activity < ActiveRecord::Base
has_one :project

attr_accessible :project_id, :message

def add_member!(user, project)
  self.message = "#{user.email} was added to project #{project.name}"
  self.project_id = project.id
  self.save
end

def create_message!(user, project)
	self.message = "#{user.name} created project #{project.name}"
	self.project_id = project.id
	self.save
end

def create_discussion!(project, discussion)
	self.message = "#{discussion.category} created for project #{project.name}"
  self.project_id = project.id
  self.save
end

def create_issue!(project, issue)
  self.message = "#{User.find(issue.author_id).name} opened issue #{issue.subject}"
  self.project_id = project.id
  self.save
end

def created
  	difference = Time.now- self.updated_at

  	days = (difference/(3600*24)).floor
  	hr = (difference/(3600)).floor
  	min = (difference/(60)).floor

  	if days > 1 
  		return "#{days} days ago"
  	elsif days == 1 
  		return "#{days} day ago"
  	elsif hr > 1 
  		return "#{hr} hours ago"
  	elsif hr == 1 
  		return "#{hr} hour ago"  	
  	elsif min > 1 || min == 0
  		return "#{min} minutes ago"
  	elsif min == 1 
  		return "#{min} minute ago"
  	end	
  end
end
