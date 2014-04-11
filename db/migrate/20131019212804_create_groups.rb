class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :owner_id
      t.string :tagline, :default => ""
      t.text :description, :default => ""
      t.boolean :inherit, :default => false
      t.boolean :private, :default => true
      t.integer :parent_id, :default => 0

      t.timestamps
    end
  end
end
