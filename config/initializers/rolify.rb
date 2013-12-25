Rolify.configure do |config|
  # By default ORM adapter is ActiveRecord. uncomment to use mongoid
  # config.use_mongoid
  
  # Dynamic shortcuts for User class (user.is_admin? like methods). Default is: false
  # Enable this feature _after_ running rake db:migrate as it relies on the roles table
  # config.use_dynamic_shortcuts

  ACCESS_LEVEL = {0 => "Owner", 1 => "Manager", 2 => "Developer", 3 => "Reporter", 4 => "Guest" }
  NOTIFICATION_LEVEL = {0 => "All Activity", 1 => "Daily Digest", 2 => "Weekly Digest", 3 => "Monthly Digest", 4 => "Never" }
end