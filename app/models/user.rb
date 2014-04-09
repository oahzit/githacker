class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :users_projects
  has_many :projects, foreign_key: "project_id", :through => :users_projects, :uniq => true

  has_many :users_groups
  attr_accessible :name, :email, :password, :password_confirmation

end
