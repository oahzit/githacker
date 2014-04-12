class Comment < ActiveRecord::Base
	attr_accessible :body, :discussion_id, :author_id
end
