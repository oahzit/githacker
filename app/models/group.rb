class Group < Repository
  has_many :users_groups, dependent: :destroy
  has_many :users, through: :users_groups

  def human_name
    name
  end

  def owners
    @owners ||= users_groups.owners.map(&:user)
  end

  def add_users(user_ids, group_access)
    user_ids.compact.each do |user_id|
      self.users_groups.create(user_id: user_id, access: group_access)
    end
  end

  def add_user(user, group_access)
    self.users_groups.create(user_id: user.id, access: group_access)
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

  def members
    users_groups
  end
end
