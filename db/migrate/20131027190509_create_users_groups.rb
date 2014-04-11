class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table :users_groups do |t|
      t.integer :access_level, :default => 0
      t.integer :group_id
      t.integer :user_id
      t.integer :notification_level, :default => 0
      t.string :name

      t.timestamps
    end
  end
end
