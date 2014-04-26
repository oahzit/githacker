class Profile < ActiveRecord::Base
	belongs_to :user

	attr_accessible :phone, :address, :city, :state, :name, :email
    validates :email, presence: true

end
