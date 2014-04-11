class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :message
      t.integer :project_id

      t.timestamps
    end
  end
end
