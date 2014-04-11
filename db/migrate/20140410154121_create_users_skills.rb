class CreateUsersSkills < ActiveRecord::Migration
  def change
    create_table :users_skills do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :level, :default => 0

      t.timestamps
    end
  end
end
