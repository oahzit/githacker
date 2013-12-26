class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table :users_groups do |t|
      t.integer :access, :default => 0
      t.integer :group_id
      t.integer :user_id
      t.integer :notification_level
      t.string :name
      t.integer :parent_id
      t.boolean :inherit

      t.timestamps
    end
  end
end
