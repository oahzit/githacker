class UserMailer < ActionMailer::Base
	default from: "kachina@alum.mit.edu"

	def welcome_email(user)
		@user = user
		@url  = 'http://githacker.herokuapp.com/login'
		mail(to: @user.email, subject: 'Welcome to GitHacker')
	end

	def add_member_email(user, project)
		@user = user
		@project = project

		mail(to: @user.email, subject: 'Welcome to your team.')
	end
end
