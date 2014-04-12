class Comment < ActiveRecord::Base
	belongs_to :discussion
	attr_accessible :body, :discussion_id, :author_id
end
