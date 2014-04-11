class AddProjectToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :group_id, :integer
    add_column :discussions, :project_id, :integer
  end
end
