class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :null => false
      t.string :path, :null => false
      t.string :tagline, :null => false
      t.text :description
      t.integer :creator_id
      t.boolean :public, :default => true, :null => false

      t.timestamps
    end
  end
end
