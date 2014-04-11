class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :discussion_id
      t.string :author_id

      t.timestamps
    end
  end
end
