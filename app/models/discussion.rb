class Discussion < ActiveRecord::Base
	attr_accessible :subject, :body, :type, :archived, :author_id, :vote_count, :status
	belongs_to :project
	has_many :comments 
	
	scope :popular, order("updated_at DESC").sort{|a,b| b.vote_count <=> a.vote_count }
	scope :recent, order("updated_at ASC")
	scope :archived, where(:archived => true)
	scope :notes, where(:type => "Note")
	scope :issues, where(:type => "Issue")
	scope :storyboard, where(:type => "Storyboard")
	scope :thread, where(:type => "Thread")

	scope :active, where(:archive => false)
	scope :archived, where(:archive => true)

	def created
		difference = Time.now- self.created_at

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

	def up_vote
		self.vote_count = self.vote_count + 1
		self.save
	end

	def down_vote
		self.vote_count = self.vote_count - 1
		self.save
	end
end
