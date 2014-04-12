class UsersGroup < ActiveRecord::Base

  attr_accessible :access_level, :user_id, :group_id

  belongs_to :user
  belongs_to :group

  scope :guests, -> { where(access_level: GUEST) }
  scope :reporters, -> { where(access_level: REPORTER) }
  scope :developers, -> { where(access_level: DEVELOPER) }
  scope :masters,  -> { where(access_level: MASTER) }
  scope :owners,  -> { where(access_level: OWNER) }
  scope :master_groups, -> { where(parent_id: null)}

  scope :with_group, ->(group) { where(group_id: group.id) }
  scope :with_user, ->(user) { where(user_id: user.id) }

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :user_id, uniqueness: { scope: [:group_id], message: "already exists in group" }

  delegate :name, :username, :email, to: :user, prefix: true

  def parent
  	Group.find(self.parent_id)
  end
  
end
