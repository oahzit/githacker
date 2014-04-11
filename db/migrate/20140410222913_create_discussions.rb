class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :subject
      t.string :body
      t.integer :type
      t.boolean :archived
      t.integer :author_id
      t.integer :vote_count
      t.integer :status

      t.timestamps
    end
  end
end
