class CreateUsersProjects < ActiveRecord::Migration
  def change
    create_table :users_projects do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :access_level, :default => 0
      t.integer :notification_level, :default => 0

      t.timestamps
    end
  end
end
