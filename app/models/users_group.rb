class UsersGroup < ActiveRecord::Base

  def self.group_access_roles
  	group_access = ["OWNER", "MASTER", "DEVELOPER", "REPORTER", "GUEST"]
    return group_access
  end

  attr_accessible :access, :user_id

  belongs_to :user
  belongs_to :group

  scope :guests, -> { where(access: GUEST) }
  scope :reporters, -> { where(access: REPORTER) }
  scope :developers, -> { where(access: DEVELOPER) }
  scope :masters,  -> { where(access: MASTER) }
  scope :owners,  -> { where(access: OWNER) }
  scope :master_groups, -> { where(parent_id: null)}

  scope :with_group, ->(group) { where(group_id: group.id) }
  scope :with_user, ->(user) { where(user_id: user.id) }

  validates :group_access, inclusion: { in: UsersGroup.group_access_roles }, presence: true
  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :user_id, uniqueness: { scope: [:group_id], message: "already exists in group" }

  delegate :name, :username, :email, to: :user, prefix: true

  def parent
  	Group.find(self.parent_id)
  end
  
end
