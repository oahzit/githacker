class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :subject
      t.text :body
      t.string :type
      t.boolean :archive, :default => false
      t.integer :author_id
      t.integer :vote_count, :default => 0
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
