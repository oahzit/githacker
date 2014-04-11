class Project < ActiveRecord::Base
	belongs_to :user
	belongs_to :repository

	has_many :users_projects
    has_many :users, foreign_key: "user_id", :through => :users_projects, :uniq => true
  has_many :activities
  has_many :discussions
  
	attr_accessible :name, :path, :tagline, :description, :creator_id, :public

  scope :public_viewing, where(:public => true)

	def last_activity_to_text
	end

	def creator
		User.find(creator_id)
	end

  def last_edited
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
