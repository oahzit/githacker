class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  accepts_nested_attributes_for :profile
  before_create :instantiate_profile

  acts_as_taggable_on :skills

  has_many :users_projects, dependent: :destroy
  has_many :projects, foreign_key: "project_id", :through => :users_projects
  has_many :users_groups, dependent: :destroy
  has_many :groups, foreign_key: "group_id", :through => :users_groups

  attr_accessible :name, :email, :password, :password_confirmation

    # Required to create complete profile for user
    def instantiate_profile
      @profile = Profile.where(:email => email).first
      if @profile.present?
        self.profile = @profile
        self.profile.update_attributes(:email => email)
      else
        self.create_profile!(:email => email)
      end
    end

    def issues
      @issues = []
      self.projects.each do |project|
        project.discussions.issues.active.recent.each do |issue|
          @issues << issue
        end
      end
      return @issues.sort_by{|e| -e[:vote_count]}
    end

    def skills
      self.skill_list
    end

  end
