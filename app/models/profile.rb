class Profile < ActiveRecord::Base
	belongs_to :user

	attr_accessible :phone, :address, :city, :state, :name
    validates :name, presence: true

end
