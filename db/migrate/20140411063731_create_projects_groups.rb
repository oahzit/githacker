class CreateProjectsGroups < ActiveRecord::Migration
  def change
    create_table :projects_groups do |t|
      t.integer :project_id
      t.integer :group_id

      t.timestamps
    end
  end
end
