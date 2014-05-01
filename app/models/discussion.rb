class Discussion < ActiveRecord::Base
	attr_accessible :subject, :body, :type, :archived, :author_id, :vote_count, :status
	belongs_to :project
	acts_as_taggable_on :skills
	acts_as_taggable_on :category
	acts_as_taggable_on :related_to

	scope :popular, -> {order("vote_count DESC")}
	scope :recent, -> {order("created_at DESC")}
	scope :notes, -> {where(:type => "Note")}
	scope :issues, -> {where(:type => "Issue")}
	scope :storyboards, -> {where(:type => "Feature")}
	scope :thread, -> {where(:type => "Thread")}

	scope :active, -> {where(:archive => false)}
	scope :archived, -> {where(:archive => true)}

	def comments
		self.related_content("Comment")
	end

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

	def related_content(type)
		content_array = []
		self.related_to_list.each do |id|
			discussion = Discussion.find(id.to_i)
			if discussion.type == type
				content_array << discussion
			end
		end
		return content_array
	end
end
