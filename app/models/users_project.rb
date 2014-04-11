class UsersProject < ActiveRecord::Base

  def self.project_access_roles
  	access = ["OWNER", "MANAGER", "DEVELOPER", "REPORTER", "GUEST"]
    return access
  end

  attr_accessible :project_id, :user_id, :access, :notification_level

  belongs_to :user
  belongs_to :project
  accepts_nested_attributes_for :project

  validates :user_id, uniqueness: { scope: [:project_id], message: "already exists in project" }
  validates :project_id, presence: true

  delegate :name, :username, :email, to: :user, prefix: true

  scope :guests, -> { where(access_level: GUEST) }
  scope :reporters, -> { where(access_level: REPORTER) }
  scope :developers, -> { where(access_level: DEVELOPER) }
  scope :masters,  -> { where(access_level: MASTER) }
  scope :owners,  -> { where(access_level: 0) }

  scope :in_project, ->(project) { where(project_id: project.id) }
  scope :in_projects, ->(projects) { where(project_id: projects.map { |p| p.id }) }
  scope :with_user, ->(user) { where(user_id: user.id) }

  class << self

    # Add users to project teams with passed access option
    #
    # access can be an integer representing a access code
    # or symbol like :master representing role
    #
    # Ex.
    #   add_users_into_projects(
    #     project_ids,
    #     user_ids,
    #     UsersProject::MASTER
    #   )
    #
    #   add_users_into_projects(
    #     project_ids,
    #     user_ids,
    #     :master
    #   )
    #

    def add_users_into_projects(project_ids, user_ids, access)
      project_access = if roles_hash.has_key?(access)
       roles_hash[access]
     elsif roles_hash.values.include?(access.to_i)
       access
     else
       raise "Non valid access"
     end

     UsersProject.transaction do
      project_ids.each do |project_id|
        user_ids.each do |user_id|
          users_project = UsersProject.new(access: project_access, user_id: user_id)
          users_project.project_id = project_id
          users_project.save
        end
      end
    end

    true
  rescue
    false
  end

  def truncate_teams(project_ids)
    UsersProject.transaction do
      users_projects = UsersProject.where(project_id: project_ids)
      users_projects.each do |users_project|
        users_project.destroy
      end
    end

    true
  rescue
    false
  end

  def truncate_team project
    truncate_teams [project.id]
  end

  def roles_hash
    Gitlab::Access.sym_options
  end

  def access_roles
    Gitlab::Access.options
  end
end


def date_added
  created_at.strftime("%b %e, %Y")
end

def creator?
  project.creator == user
end

def owner?
  self.access == 0
end

def project_access
  ACCESS_LEVEL[this.access]
end

def project_notification
  NOTIFICATION_LEVEL[notification_level]
end

end
