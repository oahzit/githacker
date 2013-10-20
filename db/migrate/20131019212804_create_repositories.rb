class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, :null => false
      t.string :path, :null => false
      t.integer :owner_id
      t.string :tagline, :default => "", :null => false
      t.text :description, :default => ""


      t.timestamps
    end
  end
end
