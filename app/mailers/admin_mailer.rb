class AdminMailer < ActionMailer::Base
	default to: Proc.new { User.pluck(:email) },
	from: 'notification@githacker.com'

	def new_registration(user)
		@user = user
		mail(subject: "New member of the team: #{@user.name}")
	end
end
