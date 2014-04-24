class Group < ActiveRecord::Base
  has_many :users_groups, dependent: :destroy
  has_many :users, foreign_key: "user_id", :through => :users_groups

  has_many :projects_groups, dependent: :destroy
  has_many :projects, foreign_key: "project_id", :through => :projects_groups

  attr_accessible :owner_id, :group_id, :access_level, :name

  def owners
    @owners ||= users_groups.owners.map(&:user)
  end

  def add_users(user_ids, group_access)
    user_ids.compact.each do |user_id|
      self.users_groups.create(user_id: user_id, access_level: group_access)
    end
  end

  def add_user(user, group_access)
    self.users_groups.create(user_id: user.id, access_level: group_access)
  end

  def add_owner(user)
    self.add_user(user, UsersGroup::OWNER)
  end

  def has_owner?(user)
    owners.include?(user)
  end

  def last_owner?(user)
    has_owner?(user) && owners.size == 1
  end

  def children
    Group.where(:parent_id => self.id).all
  end

  def members
    users
  end

  def total_members
    users 
    self.children.each do |group|
      group.total_members.each do |user|
        if !users.where(:user_id => user.id).first.present?
          users << user
        end
      end
    end
    return users
  end

end
