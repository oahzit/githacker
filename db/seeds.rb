# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

# puts 'DEFAULT USERS'
# user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
# puts 'user: ' << user.name
# user.confirm!
# user.add_role :admin

puts 'DEFAULT SKILLS'
Skill.create!(:name => "Legal")
Skill.create!(:name => "Documentation")
Skill.create!(:name => "Arduino")
Skill.create!(:name => "Electronics")
Skill.create!(:name => "Mechanical Design")
Skill.create!(:name => "Woodworking")
Skill.create!(:name => "Software")
Skill.create!(:name => "Design")
Skill.create!(:name => "Business Development")
Skill.create!(:name => "Community Management")
Skill.create!(:name => "Video")
Skill.create!(:name => "Photography")
Skill.create!(:name => "Outreach")
Skill.create!(:name => "Fundraising")