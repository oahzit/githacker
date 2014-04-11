class Discussion < ActiveRecord::Base
	attr_accessible :subject, :body, :type, :archived, :author_id, :vote_count, :status
	belongs_to :project
	has_many :comments 
	
	scope :recent, order("updated_at DESC")
	scope :archived, where(:archived => true)
	scope :notes, where(:type => 0)
	scope :issues, where(:type => 1)
	scope :storyboard, where(:type => 2)
	scope :thread, where(:type => 3)

	def category
		if self.type == 0
			return "Note"
		elsif self.type == 1
			return "Issue"
		elsif self.type == 2
			return "Storyboard"
		elsif self.type == 3
			return "Thread"
		end
	end

	def up_vote
		self.vote_count = self.vote_count + 1
	end

	def down_vote
		self.vote_count = self.vote_count - 1
	end
end
